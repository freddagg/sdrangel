///////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2017 Edouard Griffiths, F4EXB                                   //
//                                                                               //
// This program is free software; you can redistribute it and/or modify          //
// it under the terms of the GNU General Public License as published by          //
// the Free Software Foundation as version 3 of the License, or                  //
//                                                                               //
// This program is distributed in the hope that it will be useful,               //
// but WITHOUT ANY WARRANTY; without even the implied warranty of                //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the                  //
// GNU General Public License V3 for more details.                               //
//                                                                               //
// You should have received a copy of the GNU General Public License             //
// along with this program. If not, see <http://www.gnu.org/licenses/>.          //
///////////////////////////////////////////////////////////////////////////////////

#include "hackrfoutputthread.h"

#include <stdio.h>
#include <errno.h>
#include <unistd.h>

#include "dsp/samplesourcefifo.h"

HackRFOutputThread::HackRFOutputThread(hackrf_device* dev, SampleSourceFifo* sampleFifo, QObject* parent) :
	QThread(parent),
	m_running(false),
	m_dev(dev),
	m_sampleFifo(sampleFifo),
	m_log2Interp(0)
{
    std::fill(m_buf, m_buf + 2*HACKRF_BLOCKSIZE, 0);
}

HackRFOutputThread::~HackRFOutputThread()
{
	stopWork();
}

void HackRFOutputThread::startWork()
{
	m_startWaitMutex.lock();
	start();
	while(!m_running)
		m_startWaiter.wait(&m_startWaitMutex, 100);
	m_startWaitMutex.unlock();
}

void HackRFOutputThread::stopWork()
{
    if (!m_running) return;
	qDebug("HackRFOutputThread::stopWork");
	m_running = false;
	wait();
}

void HackRFOutputThread::setLog2Interpolation(unsigned int log2Interp)
{
	m_log2Interp = log2Interp;
}

void HackRFOutputThread::run()
{
	hackrf_error rc;

    m_running = true;
    m_startWaiter.wakeAll();


    if (hackrf_is_streaming(m_dev) == HACKRF_TRUE)
    {
        qDebug("HackRFInputThread::run: HackRF is streaming already");
    }
    else
    {
        qDebug("HackRFInputThread::run: HackRF is not streaming");

        rc = (hackrf_error) hackrf_start_tx(m_dev, tx_callback, this);

        if (rc == HACKRF_SUCCESS)
        {
            qDebug("HackRFOutputThread::run: started HackRF Tx");
        }
        else
        {
            qDebug("HackRFOutputThread::run: failed to start HackRF Tx: %s", hackrf_error_name(rc));
        }
    }

    while ((m_running) && (hackrf_is_streaming(m_dev) == HACKRF_TRUE))
    {
        usleep(200000);
    }

    if (hackrf_is_streaming(m_dev) == HACKRF_TRUE)
    {
        rc = (hackrf_error) hackrf_stop_tx(m_dev);

        if (rc == HACKRF_SUCCESS)
        {
            qDebug("HackRFOutputThread::run: stopped HackRF Tx");
        }
        else
        {
            qDebug("HackRFOutputThread::run: failed to stop HackRF Tx: %s", hackrf_error_name(rc));
        }
    }

	m_running = false;
}

//  Interpolate according to specified log2 (ex: log2=4 => interp=16)
void HackRFOutputThread::callback(qint8* buf, qint32 len)
{
    SampleVector::iterator beginRead;
    m_sampleFifo->readAdvance(beginRead, len/(2*(1<<m_log2Interp)));
    beginRead -= len/2;

	if (m_log2Interp == 0)
	{
	    m_interpolators.interpolate1(&beginRead, buf, len);
	}
	else
	{
        switch (m_log2Interp)
        {
        case 1:
            m_interpolators.interpolate2_cen(&beginRead, buf, len);
            break;
        case 2:
            m_interpolators.interpolate4_cen(&beginRead, buf, len);
            break;
        case 3:
            m_interpolators.interpolate8_cen(&beginRead, buf, len);
            break;
        case 4:
            m_interpolators.interpolate16_cen(&beginRead, buf, len);
            break;
        case 5:
            m_interpolators.interpolate32_cen(&beginRead, buf, len);
            break;
        case 6:
            m_interpolators.interpolate64_cen(&beginRead, buf, len);
            break;
        default:
            break;
        }
	}
}

int HackRFOutputThread::tx_callback(hackrf_transfer* transfer)
{
    HackRFOutputThread *thread = (HackRFOutputThread *) transfer->tx_ctx;
    qint32 bytes_to_write = transfer->valid_length;
	thread->callback((qint8 *) transfer->buffer, bytes_to_write);
	return 0;
}
