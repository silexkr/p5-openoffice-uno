#!/usr/local/bin/perl
#*************************************************************************
#*
#*  $RCSfile$
#*
#*  $Revision$
#*
#*  last change: $Author$ $Date$
#*
#*  The Contents of this file are made available subject to the terms of
#*  the BSD license.
#*  
#*  Copyright (c) 2003 by Sun Microsystems, Inc.
#*  All rights reserved.
#*
#*  Redistribution and use in source and binary forms, with or without
#*  modification, are permitted provided that the following conditions
#*  are met:
#*  1. Redistributions of source code must retain the above copyright
#*     notice, this list of conditions and the following disclaimer.
#*  2. Redistributions in binary form must reproduce the above copyright
#*     notice, this list of conditions and the following disclaimer in the
#*     documentation and/or other materials provided with the distribution.
#*  3. Neither the name of Sun Microsystems, Inc. nor the names of its
#*     contributors may be used to endorse or promote products derived
#*     from this software without specific prior written permission.
#*
#*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#*  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#*  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
#*  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
#*  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#*  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#*  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
#*  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#*  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
#*  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
#*  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#*     
#*************************************************************************/

# Add module path for testing
push(@INC, $ENV{'SOLARVERSION'} . "/" . $ENV{'INPATH'} . "/lib/perl");

require "Perluno.pm";

$pu = new Perluno();

if ( $#ARGV != 0 ) {
	print "Usage: loaddoc.pl <filename>\n";
	exit(-1);
}
use Cwd;
my $dir = getcwd;
$fname = $ARGV[0];
$cu = $pu->createInitialComponentContext("file://" . $dir . "/perluno");
$sm = $cu->getServiceManager();

$resolver = $sm->createInstanceWithContext("com.sun.star.bridge.UnoUrlResolver", $cu);

$smgr = $resolver->resolve("uno:socket,host=localhost,port=8100;urp;StarOffice.ServiceManager");

$rc = $smgr->getPropertyValue("DefaultContext");

$dt = $smgr->createInstanceWithContext("com.sun.star.frame.Desktop", $rc);

# create a calc document
@args = ();
$sdoc = $dt->loadComponentFromURL("file://" . $dir . "/" . $fname, "_blank", 0, \@args);

