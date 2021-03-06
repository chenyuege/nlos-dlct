% CONSTRUCTR Construct LCT resampling operators
%
%   [RX, RY, RZ] = CONSTRUCTR(M, RANGE, MU) constructs the DLCT re-
%   sampling operators RX, RY and RZ of size MxM with spatial range
%   RANGE (in meters), and extension factors MU.
%
%
%   Authors:     Sean I. Young      David B. Lindell
%   Contacts: sean0@stanford.edu, lindell@stanford.edu
%
% Copyright 2019-2020 Stanford University, Stanford CA 94305, USA
%
%                         All Rights Reserved
%
% Permission to use, copy, modify, and distribute this software and
% its documentation for any purpose other than its incorporation into
% a commercial product is hereby granted without fee, provided that
% the above copyright notice appear in all copies and that both that
% copyright notice and this permission notice appear in supporting
% documentation, and that the name of Stanford University not be used
% in advertising or publicity pertaining to distribution of the
% software without specific, written prior permission.
%
% STANFORD UNIVERSITY DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
% SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR ANY PARTICULAR PURPOSE. IN NO EVENT SHALL STANFORD
% UNIVERSITY BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
% DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
% OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
% TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
% PERFORMANCE OF THIS SOFTWARE.

function [Rx,Ry,Rz] = constructR(M,range)
% Local function that defines resampling operators
     R = sparse([],[],[],M^2,M,M^2);
     x = 1:M^2;
     R(sub2ind(size(R),x,ceil(sqrt(x)))) = 1;
     Rx = spdiags((M/range)./sqrt(x)',0,M^2,M^2)*R;
     Rz = 0.5*R;
     for k = 1:round(log2(M))
         Rx = (Rx(1:2:end,:) + Rx(2:2:end,:));
         Rz = (Rz(1:2:end,:) + Rz(2:2:end,:));
     end
     Rx = full(Rx);
     Rz = full(Rz);
     nf = 1/norm(blkdiag(Rx,Rz));
     Rx = Rx * nf;
     Rz = Rz * nf;
     Ry = Rx;
end