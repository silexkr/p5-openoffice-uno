BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Perluno;
use Devel::Peek;

$pu = new Perluno();

use Cwd;
my $dir = getcwd;
$cu = $pu->createInitialComponentContext("file://" . $dir . "/perluno");
$sm = $cu->getServiceManager();

$resolver = $sm->createInstanceWithContext("com.sun.star.bridge.UnoUrlResolver", $cu);

$smgr = $resolver->resolve("uno:socket,host=localhost,port=8100;urp;StarOffice.ServiceManager");

$rc = $smgr->getPropertyValue("DefaultContext");

$dt = $smgr->createInstanceWithContext("com.sun.star.frame.Desktop", $rc);

# create a calc document
$pv = $pu->createIdlStruct("com.sun.star.beans.PropertyValue");

$pv->Name("Hidden");
$pv->Value(1);

@args = ( $pv );

$sdoc = $dt->loadComponentFromURL("file://" . $dir . "/test1.sxw", "_blank", 0, \@args);

$loaded = 1;

print "ok 1\n";
