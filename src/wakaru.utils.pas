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
unit wakaru.utils;

{$mode delphi}

interface

uses
  Classes,
  SysUtils,
  wakaru.consts;

  (*
    provided a range, this method will return the appropriate signal
    enumeration it belongs to
  *)
  function RangeToSignal(Const ARange : TSignalRange) : TSignal;

implementation

function RangeToSignal(const ARange: TSignalRange): TSignal;
begin
  //map the input range to the corresponding signal enum
  if (ARange >= Low(TAlphaRange)) and (ARange <= High(TAlphaRange)) then
    Exit(sgAlpha)
  else if (ARange >= Low(TBetaRange)) and (ARange <= High(TBetaRange)) then
    Exit(sgBeta)
  else if (ARange >= Low(TGammaRange)) and (ARange <= High(TGammaRange)) then
    Exit(sgGamma)
  else
    Exit(sgDelta);
end;

end.

