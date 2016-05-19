library(yaml)
library(XML)
library(stringr)

files <- list.files("../courses/08_PracticalMachineLearning/", 
                    pattern = "Rmd$", recursive = TRUE, 
                    full.names = TRUE)
week_names <- dirname(files)
file.copy(week_names, "Practical_Machine_Learning", recursive = TRUE)

rmds <- list.files("Practical_Machine_Learning",
                   pattern = "Rmd$", full.names = TRUE,
                   recursive = TRUE)

for(i in rmds){
  index.Rmd <- readLines(i, warn = FALSE)
  breaks <- grep("---", index.Rmd)
  temp <- tempfile()
  writeLines(index.Rmd[(breaks[1] + 1):(breaks[2] - 1)], temp)
  front_matter_old <- yaml.load_file(temp)
  # front_matter_new <- list(title = "", author = "",
  #                          output = 
  #                            list(ioslides_presentation = 
  #                                   list(logo = "../../img/bloomberg_shield.png"),
  #                                 beamer_presentation = "default"),
  #                          always_allow_html = "yes")
  front_matter_new <- list(title = "", author = "",
                           always_allow_html = "yes")
  front_matter_new$title <- front_matter_old$title
  front_matter_new$author <- front_matter_old$author
  new_yaml <- tempfile()
  cat(as.yaml(front_matter_new), file = new_yaml)
  yaml_insert <- c("---", readLines(new_yaml, warn = FALSE), "---")
  index.Rmd <- index.Rmd[-c((breaks[1]:breaks[2]), breaks[-(1:2)])]
  index.Rmd <- c(yaml_insert, index.Rmd)
  
  chunks <- grep("```", index.Rmd)
  bad_chunk <- grep("```\\{r setup", index.Rmd)
  if(length(bad_chunk) > 0){
    index.Rmd <- index.Rmd[-(bad_chunk:(chunks[which(chunks == bad_chunk) + 1]))]  
  }
  
  imgs <- grep("<img", index.Rmd)
  if(length(imgs) > 0){
    img_tags <- index.Rmd[imgs]
    srcs <- unlist(xpathApply(htmlParse(img_tags), '//img', xmlGetAttr,"src"))
    md_images <- paste0("![", basename(srcs), "](", srcs,")")
    index.Rmd[imgs] <- md_images
  }

  unlink(i)
  writeLines(index.Rmd, i)
}

