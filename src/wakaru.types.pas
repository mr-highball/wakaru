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
unit wakaru.types;

{$mode delphi}{$H+}

interface

uses
  Classes,
  SysUtils,
  wakaru.consts;

type

  (*
    a node connection binds node(s) together but always has only
    one source node
  *)
  INodeConnection = interface
    ['{1187154A-EF72-4BF5-A975-D28FA418726D}']
  end;

  (*
    nodes are interconnected constructs that accept
    signals and express a value. additionally, nodes transmit
    signals through node connections when thresholds are met
  *)
  INode = interface
    ['{0B7F6660-5A94-4F70-8434-E9865A2C7004}']
  end;

  (*
    a node cluster is a collection of connected nodes and has the
    roles of taking the signal measurement of all nodes, as well as
    distributing incoming external signal information
  *)
  INodeCluster = interface
    ['{53CF34C9-D26E-475A-B412-34239499824F}']
  end;

  (*
    the network is a collection of at least one node cluster. primary
    responsibilities include distributing external signals to clusters,
    maintaining the "pulse", and recording finalized signals for the clusters
    for a given pulse. this can also be seen as the top level interface
    when working with nodes
  *)
  INodeNetwork = interface
    ['{821D75CF-455A-434B-9406-29B3CA0CA224}']
  end;

implementation

end.

