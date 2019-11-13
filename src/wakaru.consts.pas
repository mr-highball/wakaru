{ wakaru

  Copyright (c) 2019 mr-highball

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}
unit wakaru.consts;

{$mode delphi}

interface

const
  (*
    define ranges according to the max int size. this may change in the
    future
  *)
  SIGNAL_RANGE_STEP = MaxInt div 4;
  SIGNAL_RANGE_MAX = MaxInt;

type

  (*
    signals are produced by node clusters when a measurement is taken
  *)
  TSignal = (
    sgAlpha,
    sgBeta,
    sgGamma,
    sgDelta
  );

  TSignals = set of TSignal;

  (*
    define the ranges for each signal
  *)
  TSignalRange = Integer;
  TAlphaRange = 0 .. SIGNAL_RANGE_STEP;
  TBetaRange = Succ(High(TAlphaRange)) .. High(TAlphaRange) + SIGNAL_RANGE_STEP;
  TGammaRange = Succ(High(TBetaRange)) .. High(TBetaRange) + SIGNAL_RANGE_STEP;
  TDeltaRange = Succ(High(TGammaRange)) .. SIGNAL_RANGE_MAX;

implementation

end.

