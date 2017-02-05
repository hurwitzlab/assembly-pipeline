setwd("/Users/Scott/contigs-unknown/")

good_pred<-read.table("good_gene_names_from_unknown.tab",header=T,as.is=T)

whole_gff<-read.delim("contigs-longer-than-1000.gff",header = F,comment.char = "#",as.is=T)

#ran this in shell
# perl -nle '($id)=/ID=([^;]*)/; print "$id"' contigs-longer-than-1000.gff > id_for_gff.tab

ids<-read.delim("id_for_gff.tab",header = F,as.is=T)

row.names(whole_gff)<-ids$V1

good_gff<-whole_gff[good_pred$tracking_id,]

write.table(good_gff,file="good_predictions_for_contigs.gff",quote = F,sep = "\t",row.names = F,col.names = F)

#ran this in shell
#grep '^#' contigs-longer-than-1000.gff > header.gff
#cat header.gff good_predictions_for_contigs.gff > good_predictions_for_contigs.temp
#mv good_predictions_for_contigs.temp good_predictions_for_contigs.gff
#
#and to test it worked
#
#bedtools getfasta -fi contigs-longer-than-1000.fa -bed good_predictions_for_contigs.gff
#which outputted fasta meaning the gff is well-formed, yay!
