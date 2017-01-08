#Commands and file descriptions

contigs-longer-than-1000.fa = about 300K contigs

contigs-longer-than-1000.fa-prodigal.fa = same file but with coding regions identified by prodigal on the UA hpc's

**I went with two command chains because I wasn't sure where RASTtk was erroring**


#command chain for contigs-longer-than-1000.fa-prodigal.fa
rast-create-genome --contigs ~/contigs-unknown/contigs-longer-than-1000.fa-prodigal.fa --domain Bacteria --genetic-code 11 > ~/contigs-unknown/prodigal.gto

rast-annotate-proteins-kmer-v2 < ~/contigs-unknown/prodigal.gto > ~/contigs-unknown/prodigal2.gto

rast-annotate-proteins-kmer-v1 -H < ~/contigs-unknown/prodigal2.gto > ~/contigs-unknown/prodigal3.gto

rast-resolve-overlapping-features < ~/contigs-unknown/prodigal3.gto > ~/contigs-unknown/prodigal4.gto

rast-export-genome gff < ~/contigs-unknown/prodigal4.gto > ~/contigs-unknown/contigs-longer-than-1000.gff

#command chain for contigs-longer-than-1000.fa
rast-create-genome --domain Bacteria --genetic-code 11 --contigs ~/contigs-unknown/contigs-longer-than-1000.fa > ~/contigs-unknown/onethou.gto

rast-call-features-CDS-prodigal < ~/contigs-unknown/onethou.gto > ~/contigs-unknown/onethou2.gto

**Errored out here** perl(16828,0xa50c11c0) malloc: *** mach_vm_map(size=393281536) failed (error code=3)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
Out of memory!**

rast-annotate-proteins-kmer-v2 < ~/contigs-unknown/onethou2.gto > ~/contigs-unknown/onethou3.gto

rast-annotate-proteins-kmer-v1 -H < ~/contigs-unknown/onethou3.gto > ~/contigs-unknown/onethou4.gto

rast-resolve-overlapping-features < ~/contigs-unknown/onethou4.gto > ~/contigs-unknown/onethou5.gto



