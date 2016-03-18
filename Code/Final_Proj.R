#add an r script to allow it to be called from the command line


library(ape)
library(geiger)
library(phytools)
library(tools)

Make_MrBayes_Constraint <- function(path_to_file) {
#turns a newick file (.txt) into a MrBayes Constraint
#tree must be in newick format, comma separated, ending with a ";"
#need to library(ape);(geiger);(phytools)

  my_tree<-read.newick(file=path_to_file)
  external_nodes <- length(my_tree$tip.label) #returns tip labels
  internal_nodes <- my_tree$Nnode #returns internal nodes
  myvec <- (external_nodes + 2) : (external_nodes + internal_nodes)
  for (i in myvec){ 
    whole_tree_list <- tips(my_tree,external_nodes + 1)
    monophyletic_group  <- tips(my_tree,i)
    a <- monophyletic_group
    b <- setdiff(whole_tree_list,monophyletic_group)
    colon <- ":"
    semi <- ";"
    string_one <- paste(a, collapse=' ' )
    string_two <- paste(b, collapse=' ' )
    write(paste0(paste("constraint", paste0("backbone",i - (external_nodes+1)), "partial =", paste(string_one, colon, string_two)),semi), file = paste0(file_path_sans_ext(path_to_file),'.output.txt'), append = TRUE )
  }
  counter <- internal_nodes - 1
  comma <- ","
  vector <- "prset topologypr = constraints("
  for(i in 1:counter){
    vector <- c(vector, paste0(" backbone",i,comma))
  }
  need_ending <- paste(vector, sep="", collapse="")
  priorset <- sub(".$", "", need_ending) 
  write(paste0(priorset, ");"), file = paste0(file_path_sans_ext(path_to_file),'.output.txt'), append=TRUE)
}

Constraint_All_in_Dir <- function(path_to_directory) {
  #makes a MrBayes constraint for all the newick files (.txt) in a folder
  #need to specify folder name 
  filenames <- list.files(path_to_directory, pattern="*.txt")
  path_to_myfile <- paste(path_to_directory, filenames, sep="/")
  for (i in 1:length(filenames)) {
    Make_MrBayes_Constraint(path_to_myfile[i])
  }
}

myargs <- commandArgs(trailingOnly = TRUE)
Constraint_All_in_Dir(myargs[1])
