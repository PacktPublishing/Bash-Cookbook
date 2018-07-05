$ #!/bin/bash
BDIR="files_galore"
rm -rf ${BDIR}
mkdir -p ${BDIR}

touch $BDIR/file1; echo "1111111111111111111111111111111" > 
$BDIR/file1;
touch $BDIR/file2; echo "2222222222222222222222222222222" > $BDIR/file2;
touch $BDIR/file3; echo "3333333333333333333333333333333" > $BDIR/file3;
touch $BDIR/file4; echo "4444444444444444444444444444444" > $BDIR/file4;
touch $BDIR/file5; echo "4444444444444444444444444444444" > $BDIR/file5;
touch $BDIR/sameas5; echo "4444444444444444444444444444444" > $BDIR/sameas5;
touch $BDIR/sameas1; echo "1111111111111111111111111111111" > $BDIR/sameas1;
