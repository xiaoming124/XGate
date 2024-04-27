#!/usr/bin/env python2
# -*- coding: utf-8 -*-
#
# SPDX-License-Identifier: GPL-3.0
#
##################################################
# GNU Radio Python Flow Graph
# Title: Rtl Sdr
# Generated: Wed Jul 11 14:11:44 2018
# GNU Radio version: 3.7.12.0
##################################################

if __name__ == '__main__':
    import ctypes
    import sys
    if sys.platform.startswith('linux'):
        try:
            x11 = ctypes.cdll.LoadLibrary('libX11.so')
            x11.XInitThreads()
        except:
            print "Warning: failed to XInitThreads()"

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import wxgui
from gnuradio.eng_option import eng_option
from gnuradio.fft import window
from gnuradio.filter import firdes
from gnuradio.filter import pfb
from gnuradio.wxgui import fftsink2
from gnuradio.wxgui import forms
from grc_gnuradio import wxgui as grc_wxgui
from optparse import OptionParser
import lora
import math
import osmosdr
import time
import wx


class rtl_sdr(grc_wxgui.top_block_gui):

    def __init__(self):
        grc_wxgui.top_block_gui.__init__(self, title="Rtl Sdr")
        _icon_path = "/usr/share/icons/hicolor/32x32/apps/gnuradio-grc.png"
        self.SetIcon(wx.Icon(_icon_path, wx.BITMAP_TYPE_ANY))

        ##################################################
        # Variables
        ##################################################
        self.spreading_factor = spreading_factor = 8
        self.samp_rate = samp_rate = 0.5e6
        self.rx_gain = rx_gain = 10
        self.offset = offset = 0
        self.ldr = ldr = True
        self.header = header = False
        self.frequency = frequency = 914.95e6
        self.code_rate = code_rate = 4
        self.bw = bw = 250e3
        self.RF_gain = RF_gain = 10
        self.IF_gain = IF_gain = 20
        self.BB_gain = BB_gain = 20

        ##################################################
        # Blocks
        ##################################################
        self._frequency_text_box = forms.text_box(
        	parent=self.GetWin(),
        	value=self.frequency,
        	callback=self.set_frequency,
        	label='frequency',
        	converter=forms.float_converter(),
        )
        self.Add(self._frequency_text_box)
        self._bw_text_box = forms.text_box(
        	parent=self.GetWin(),
        	value=self.bw,
        	callback=self.set_bw,
        	label='bw',
        	converter=forms.float_converter(),
        )
        self.Add(self._bw_text_box)
        _RF_gain_sizer = wx.BoxSizer(wx.VERTICAL)
        self._RF_gain_text_box = forms.text_box(
        	parent=self.GetWin(),
        	sizer=_RF_gain_sizer,
        	value=self.RF_gain,
        	callback=self.set_RF_gain,
        	label='RF_gain',
        	converter=forms.float_converter(),
        	proportion=0,
        )
        self._RF_gain_slider = forms.slider(
        	parent=self.GetWin(),
        	sizer=_RF_gain_sizer,
        	value=self.RF_gain,
        	callback=self.set_RF_gain,
        	minimum=0,
        	maximum=89,
        	num_steps=90,
        	style=wx.SL_HORIZONTAL,
        	cast=float,
        	proportion=1,
        )
        self.Add(_RF_gain_sizer)
        _IF_gain_sizer = wx.BoxSizer(wx.VERTICAL)
        self._IF_gain_text_box = forms.text_box(
        	parent=self.GetWin(),
        	sizer=_IF_gain_sizer,
        	value=self.IF_gain,
        	callback=self.set_IF_gain,
        	label='IF_gain',
        	converter=forms.float_converter(),
        	proportion=0,
        )
        self._IF_gain_slider = forms.slider(
        	parent=self.GetWin(),
        	sizer=_IF_gain_sizer,
        	value=self.IF_gain,
        	callback=self.set_IF_gain,
        	minimum=0,
        	maximum=89,
        	num_steps=90,
        	style=wx.SL_HORIZONTAL,
        	cast=float,
        	proportion=1,
        )
        self.Add(_IF_gain_sizer)
        _BB_gain_sizer = wx.BoxSizer(wx.VERTICAL)
        self._BB_gain_text_box = forms.text_box(
        	parent=self.GetWin(),
        	sizer=_BB_gain_sizer,
        	value=self.BB_gain,
        	callback=self.set_BB_gain,
        	label='BB_gain',
        	converter=forms.float_converter(),
        	proportion=0,
        )
        self._BB_gain_slider = forms.slider(
        	parent=self.GetWin(),
        	sizer=_BB_gain_sizer,
        	value=self.BB_gain,
        	callback=self.set_BB_gain,
        	minimum=0,
        	maximum=89,
        	num_steps=90,
        	style=wx.SL_HORIZONTAL,
        	cast=float,
        	proportion=1,
        )
        self.Add(_BB_gain_sizer)
        self.wxgui_fftsink2_0 = fftsink2.fft_sink_c(
        	self.GetWin(),
        	baseband_freq=frequency,
        	y_per_div=10,
        	y_divs=10,
        	ref_level=0,
        	ref_scale=2.0,
        	sample_rate=samp_rate,
        	fft_size=1024,
        	fft_rate=15,
        	average=False,
        	avg_alpha=None,
        	title='FFT Plot',
        	peak_hold=False,
        )
        self.Add(self.wxgui_fftsink2_0.win)
        _rx_gain_sizer = wx.BoxSizer(wx.VERTICAL)
        self._rx_gain_text_box = forms.text_box(
        	parent=self.GetWin(),
        	sizer=_rx_gain_sizer,
        	value=self.rx_gain,
        	callback=self.set_rx_gain,
        	label='rx_gain',
        	converter=forms.float_converter(),
        	proportion=0,
        )
        self._rx_gain_slider = forms.slider(
        	parent=self.GetWin(),
        	sizer=_rx_gain_sizer,
        	value=self.rx_gain,
        	callback=self.set_rx_gain,
        	minimum=0,
        	maximum=89,
        	num_steps=90,
        	style=wx.SL_HORIZONTAL,
        	cast=float,
        	proportion=1,
        )
        self.Add(_rx_gain_sizer)
        self.rtlsdr_source_0 = osmosdr.source( args="numchan=" + str(1) + " " + '' )
        self.rtlsdr_source_0.set_sample_rate(samp_rate)
        self.rtlsdr_source_0.set_center_freq(frequency, 0)
        self.rtlsdr_source_0.set_freq_corr(0, 0)
        self.rtlsdr_source_0.set_dc_offset_mode(0, 0)
        self.rtlsdr_source_0.set_iq_balance_mode(0, 0)
        self.rtlsdr_source_0.set_gain_mode(False, 0)
        self.rtlsdr_source_0.set_gain(RF_gain, 0)
        self.rtlsdr_source_0.set_if_gain(IF_gain, 0)
        self.rtlsdr_source_0.set_bb_gain(BB_gain, 0)
        self.rtlsdr_source_0.set_antenna('', 0)
        self.rtlsdr_source_0.set_bandwidth(0, 0)

        self.pfb_arb_resampler_xxx_0 = pfb.arb_resampler_ccf(
        	  bw/samp_rate,
                  taps=None,
        	  flt_size=32)
        self.pfb_arb_resampler_xxx_0.declare_sample_delay(0)

        _offset_sizer = wx.BoxSizer(wx.VERTICAL)
        self._offset_text_box = forms.text_box(
        	parent=self.GetWin(),
        	sizer=_offset_sizer,
        	value=self.offset,
        	callback=self.set_offset,
        	label='offset',
        	converter=forms.float_converter(),
        	proportion=0,
        )
        self._offset_slider = forms.slider(
        	parent=self.GetWin(),
        	sizer=_offset_sizer,
        	value=self.offset,
        	callback=self.set_offset,
        	minimum=-samp_rate/2,
        	maximum=samp_rate/2,
        	num_steps=999,
        	style=wx.SL_HORIZONTAL,
        	cast=float,
        	proportion=1,
        )
        self.Add(_offset_sizer)
        self.lora_demod_0 = lora.demod(spreading_factor, ldr, 25.0, 2)
        self.lora_decode_0 = lora.decode(spreading_factor, code_rate, ldr, header)
        self.blocks_socket_pdu_0 = blocks.socket_pdu("UDP_CLIENT", '127.0.0.1', '52002', 10000, False)
        self.blocks_message_debug_0_0_0 = blocks.message_debug()
        self.blocks_message_debug_0_0 = blocks.message_debug()



        ##################################################
        # Connections
        ##################################################
        self.msg_connect((self.lora_decode_0, 'out'), (self.blocks_message_debug_0_0, 'print_pdu'))
        self.msg_connect((self.lora_decode_0, 'out'), (self.blocks_socket_pdu_0, 'pdus'))
        self.msg_connect((self.lora_demod_0, 'out'), (self.blocks_message_debug_0_0, 'print'))
        self.msg_connect((self.lora_demod_0, 'out'), (self.blocks_message_debug_0_0_0, 'print_pdu'))
        self.msg_connect((self.lora_demod_0, 'out'), (self.lora_decode_0, 'in'))
        self.connect((self.pfb_arb_resampler_xxx_0, 0), (self.lora_demod_0, 0))
        self.connect((self.pfb_arb_resampler_xxx_0, 0), (self.wxgui_fftsink2_0, 0))
        self.connect((self.rtlsdr_source_0, 0), (self.pfb_arb_resampler_xxx_0, 0))

    def get_spreading_factor(self):
        return self.spreading_factor

    def set_spreading_factor(self, spreading_factor):
        self.spreading_factor = spreading_factor

    def get_samp_rate(self):
        return self.samp_rate

    def set_samp_rate(self, samp_rate):
        self.samp_rate = samp_rate
        self.wxgui_fftsink2_0.set_sample_rate(self.samp_rate)
        self.rtlsdr_source_0.set_sample_rate(self.samp_rate)
        self.pfb_arb_resampler_xxx_0.set_rate(self.bw/self.samp_rate)

    def get_rx_gain(self):
        return self.rx_gain

    def set_rx_gain(self, rx_gain):
        self.rx_gain = rx_gain
        self._rx_gain_slider.set_value(self.rx_gain)
        self._rx_gain_text_box.set_value(self.rx_gain)

    def get_offset(self):
        return self.offset

    def set_offset(self, offset):
        self.offset = offset
        self._offset_slider.set_value(self.offset)
        self._offset_text_box.set_value(self.offset)

    def get_ldr(self):
        return self.ldr

    def set_ldr(self, ldr):
        self.ldr = ldr

    def get_header(self):
        return self.header

    def set_header(self, header):
        self.header = header

    def get_frequency(self):
        return self.frequency

    def set_frequency(self, frequency):
        self.frequency = frequency
        self._frequency_text_box.set_value(self.frequency)
        self.wxgui_fftsink2_0.set_baseband_freq(self.frequency)
        self.rtlsdr_source_0.set_center_freq(self.frequency, 0)

    def get_code_rate(self):
        return self.code_rate

    def set_code_rate(self, code_rate):
        self.code_rate = code_rate

    def get_bw(self):
        return self.bw

    def set_bw(self, bw):
        self.bw = bw
        self._bw_text_box.set_value(self.bw)
        self.pfb_arb_resampler_xxx_0.set_rate(self.bw/self.samp_rate)

    def get_RF_gain(self):
        return self.RF_gain

    def set_RF_gain(self, RF_gain):
        self.RF_gain = RF_gain
        self._RF_gain_slider.set_value(self.RF_gain)
        self._RF_gain_text_box.set_value(self.RF_gain)
        self.rtlsdr_source_0.set_gain(self.RF_gain, 0)

    def get_IF_gain(self):
        return self.IF_gain

    def set_IF_gain(self, IF_gain):
        self.IF_gain = IF_gain
        self._IF_gain_slider.set_value(self.IF_gain)
        self._IF_gain_text_box.set_value(self.IF_gain)
        self.rtlsdr_source_0.set_if_gain(self.IF_gain, 0)

    def get_BB_gain(self):
        return self.BB_gain

    def set_BB_gain(self, BB_gain):
        self.BB_gain = BB_gain
        self._BB_gain_slider.set_value(self.BB_gain)
        self._BB_gain_text_box.set_value(self.BB_gain)
        self.rtlsdr_source_0.set_bb_gain(self.BB_gain, 0)


def main(top_block_cls=rtl_sdr, options=None):

    tb = top_block_cls()
    tb.Start(True)
    tb.Wait()


if __name__ == '__main__':
    main()
