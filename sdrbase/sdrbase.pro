#--------------------------------------------------------
#
# Pro file for Android and Windows builds with Qt Creator
#
#--------------------------------------------------------

QT += core gui multimedia opengl
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TEMPLATE = lib
TARGET = sdrbase
INCLUDEPATH += $$PWD

DEFINES += USE_KISSFFT=1
DEFINES += __WINDOWS__=1
DEFINES += DSD_USE_SERIALDV=1

CONFIG(Release):build_subdir = release
CONFIG(Debug):build_subdir = debug

CONFIG(ANDROID):INCLUDEPATH += /opt/softs/boost_1_60_0

CONFIG(MINGW32):INCLUDEPATH += "D:\boost_1_58_0"
CONFIG(MINGW64):INCLUDEPATH += "D:\boost_1_58_0"

CONFIG(MINGW32):INCLUDEPATH += "D:\softs\serialDV"
CONFIG(MINGW64):INCLUDEPATH += "D:\softs\serialDV"

SOURCES += mainwindow.cpp\
        audio/audiodeviceinfo.cpp\
        audio/audiofifo.cpp\
        audio/audiooutput.cpp\
        device/deviceapi.cpp\
        dsp/afsquelch.cpp\
        dsp/agc.cpp\
        dsp/downchannelizer.cpp\
        dsp/channelmarker.cpp\
        dsp/ctcssdetector.cpp\
        dsp/dspcommands.cpp\
        dsp/dspengine.cpp\
        dsp/dspdeviceengine.cpp\
        dsp/dvserialengine.cpp\
        dsp/dvserialworker.cpp\
        dsp/fftengine.cpp\
        dsp/kissengine.cpp\
        dsp/fftfilt.cxx\
        dsp/fftwindow.cpp\
        dsp/filterrc.cpp\
        dsp/filtermbe.cpp\
        dsp/filerecord.cpp\
        dsp/interpolator.cpp\
        dsp/inthalfbandfilter.cpp\
        dsp/lowpass.cpp\
        dsp/movingaverage.cpp\
        dsp/nco.cpp\
        dsp/pidcontroller.cpp\
        dsp/phaselock.cpp\
        dsp/samplefifo.cpp\
        dsp/basebandsamplesink.cpp\
        dsp/nullsink.cpp\
        dsp/spectrumscopecombovis.cpp\
        dsp/scopevis.cpp\
        dsp/spectrumvis.cpp\
        dsp/threadedsamplesink.cpp\
        gui/aboutdialog.cpp\
        gui/addpresetdialog.cpp\
        gui/basicchannelsettingswidget.cpp\
        gui/buttonswitch.cpp\
        gui/channelwindow.cpp\
        gui/colormapper.cpp\
        gui/glscope.cpp\
        gui/glscopegui.cpp\
        gui/glshadersimple.cpp\
        gui/glshadertextured.cpp\
        gui/glspectrum.cpp\
        gui/glspectrumgui.cpp\
        gui/indicator.cpp\
        gui/pluginsdialog.cpp\
        gui/audiodialog.cpp\
        gui/presetitem.cpp\
        gui/rollupwidget.cpp\
        gui/samplingdevicecontrol.cpp\
        gui/mypositiondialog.cpp\
        gui/scale.cpp\
        gui/scaleengine.cpp\
        gui/valuedial.cpp\
        dsp/samplesource.cpp\
        plugin/pluginapi.cpp\
        plugin/plugininterface.cpp\
        plugin/pluginmanager.cpp\
        settings/preferences.cpp\
        settings/preset.cpp\
        settings/mainsettings.cpp\
        util/CRC64.cpp\
        util/db.cpp\
        util/message.cpp\
        util/messagequeue.cpp\
        util/prettyprint.cpp\
        util/syncmessenger.cpp\
        util/samplesourceserializer.cpp\
        util/simpleserializer.cpp

HEADERS  += mainwindow.h\
        audio/audiodeviceinfo.h\
        audio/audiofifo.h\
        audio/audiooutput.h\
        device/deviceapi.h\
        dsp/afsquelch.h\
        dsp/downchannelizer.h\
        dsp/channelmarker.h\
        dsp/complex.h\
        dsp/decimators.h\
        dsp/dspcommands.h\
        dsp/dspengine.h\
        dsp/dspdeviceengine.h\
        dsp/dvserialengine.h\
        dsp/dvserialworker.h\
        dsp/dsptypes.h\
        dsp/fftengine.h\
        dsp/fftfilt.h\
        dsp/fftwengine.h\
        dsp/fftwindow.h\
        dsp/filterrc.h\
        dsp/filtermbe.h\
        dsp/filerecord.h\
        dsp/gfft.h\
        dsp/interpolator.h\
        dsp/inthalfbandfilter.h\
        dsp/kissfft.h\
        dsp/kissengine.h\
        dsp/lowpass.h\
        dsp/misc.h\
        dsp/movingaverage.h\
        dsp/nco.h\
        dsp/phasediscri.h\
        dsp/phaselock.h\
        dsp/pidcontroller.h\
        dsp/samplefifo.h\
        dsp/basebandsamplesink.h\
        dsp/nullsink.h\
        dsp/scopevis.h\
        dsp/spectrumvis.h\
        dsp/threadedsamplesink.h\
        gui/aboutdialog.h\
        gui/addpresetdialog.h\
        gui/audiodialog.h\
        gui/basicchannelsettingswidget.h\
        gui/buttonswitch.h\
        gui/channelwindow.h\
        gui/colormapper.h\
        gui/glscope.h\
        gui/glscopegui.h\
        gui/glshadersimple.h\
        gui/glshadertextured.h\
        gui/glspectrum.h\
        gui/glspectrumgui.h\
        gui/indicator.h\
        gui/physicalunit.h\
        gui/pluginsdialog.h\
        gui/presetitem.h\
        gui/rollupwidget.h\
        gui/samplingdevicecontrol.h\
        gui/mypositiondialog.h\
        gui/scale.h\
        gui/scaleengine.h\
        gui/valuedial.h\
        dsp/samplesource.h\
        plugin/pluginapi.h\
        plugin/plugingui.h\
        plugin/plugininterface.h\
        plugin/pluginmanager.h\
        settings/preferences.h\
        settings/preset.h\
        settings/mainsettings.h\
        util/CRC64.h\
        util/db.h\
        util/export.h\
        util/message.h\
        util/messagequeue.h\
        util/prettyprint.h\
        util/syncmessenger.h\
        util/samplesourceserializer.h\
        util/simpleserializer.h

FORMS    += mainwindow.ui\
        gui/scopewindow.ui\
        gui/addpresetdialog.ui\
        gui/basicchannelsettingswidget.ui\
        gui/audiodialog.ui\
        gui/glscopegui.ui\
        gui/aboutdialog.ui\
        gui/pluginsdialog.ui\
        gui/samplingdevicecontrol.ui\
        gui/myposdialog.ui\
        gui/glspectrumgui.ui\
        mainwindow.ui

RESOURCES = resources/res.qrc

LIBS += -L../serialdv/$${build_subdir} -lserialdv

CONFIG(ANDROID):CONFIG += mobility
CONFIG(ANDROID):MOBILITY =
