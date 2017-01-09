#Commands and file descriptions

contigs-longer-than-1000.fa = about 300K contigs

contigs-longer-than-1000.fa-prodigal.fa = same file but with coding regions identified by prodigal on the UA hpc's

**I went with two command chains because I wasn't sure where RASTtk was erroring**
**This is going to be more like "don't do this" / a log file of errors than a README**

#command chain for contigs-longer-than-1000.fa-prodigal.fa
rast-create-genome --contigs ~/contigs-unknown/contigs-longer-than-1000.fa-prodigal.fa --domain Bacteria --genetic-code 11 > ~/contigs-unknown/prodigal.gto

rast-annotate-proteins-kmer-v2 < ~/contigs-unknown/prodigal.gto > ~/contigs-unknown/prodigal2.gto

rast-annotate-proteins-kmer-v1 -H < ~/contigs-unknown/prodigal2.gto > ~/contigs-unknown/prodigal3.gto

rast-resolve-overlapping-features < ~/contigs-unknown/prodigal3.gto > ~/contigs-unknown/prodigal4.gto

rast-export-genome gff < ~/contigs-unknown/prodigal4.gto > ~/contigs-unknown/contigs-longer-than-1000.gff

**And this command chain is bogus because it never annotated a FEATURE! because you have to run prodigal through RASTtk**

#command chain for contigs-longer-than-1000.fa
rast-create-genome --domain Bacteria --genetic-code 11 --contigs ~/contigs-unknown/contigs-longer-than-1000.fa > ~/contigs-unknown/onethou.gto

rast-call-features-CDS-prodigal < ~/contigs-unknown/onethou.gto > ~/contigs-unknown/onethou2.gto

**Errored out here** perl(16828,0xa50c11c0) malloc: *** mach_vm_map(size=393281536) failed (error code=3)
*** error: can't allocate region
*** set a breakpoint in malloc_error_break to debug
Out of memory!**

#Finally
**split the contigs-longer-than-1000.fa into two files**

split -n l/2 contigs-longer-than-1000.fa
mv xab onethous-part1.fa
mv xaa onethous-part2.fa

and then do the following for each:
rast-create-genome
rast-call-features-CDS-prodigal
rast-annotate-proteins-kmer-v2
rast-annotate-proteins-kmer-v1 -H
rast-resolve-overlapping-features
rast-export-genome gff

and then just "cat part1.gff part2.gff > contigs-longer-than-1000.gff"
at the end
