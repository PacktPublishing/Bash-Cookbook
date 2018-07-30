#!/bin/bash
gunzip /work/tar.gz
tar uvf /work.tar /work/
gzip /work.tar
