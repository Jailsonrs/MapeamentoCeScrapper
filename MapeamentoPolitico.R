library(tidyr)
library(RSelenium)
library(dplyr)
library(rvest)
library(devtools)

selectTurno <- function(turn){
    turno <- remDr$findElements(using="xpath", value='//*[@id="P1_TURNO"]')
    turno[[1]]$clickElement()
    turno[[1]]$sendKeysToElement(list(as.character(turn)))
    turno[[1]]$clickElement()
}



remDr <- remoteDriver(port = 32769L)
remDr$open()

remDr$navigate("https://www.agrimark.coop/")

login <- remDr$findElements(using="xpath",'//*[@id="memberuser"]')
login[[2]]$sendKeysToElement(list("1231231"))
                                                   
                                                   
                                                   
                                                   
                                                   
remDr$navigate("http://www.tse.jus.br/eleicoes/eleicoes-2018/boletim-de-urna-na-web")

webElem <- remDr$findElements("css", "iframe")
remDr$switchToFrame(webElem[[1]])

selectTurno(1)

UF = remDr$findElements("xpath", '//*[@id="P1_UF"]')
UF[[1]]$clickElement()
UF[[1]]$sendKeysToElement(list("c"))
MU = remDr$findElements("xpath", '//*[@id="P1_MUN"]')

for(i in 1:3){
  MU[[1]]$sendKeysToElement(list("f"))
}

ZONA <- remDr$findElements("xpath", '//*[@id="P1_ZONA"]')
ZONA[[1]]$clickElement()

option <- remDr$findElement(using = 'xpath', 
                            "/html/body/form/div[1]/div/div[2]/div/div[1]/div/div/div/div[2]/div[2]/div/div[2]/div[1]/div/div[2]/select/option[3]")
option$clickElement()

secao <- remDr$findElements(using = "xpath", value = '//*[@id="P1_SECAO"]')
pesquisar <- remDr$findElements(using = "xpath", value= '//*[@id="PESQUISAR"]')

#cada secao
for(i in 1:586){
  secaoi <- remDr$findElements(using = "xpath", 
                               value = paste0('/html/body/form/div[1]/div/div[2]/div/div[1]/div/div/div/div[2]/div[2]/div/div[2]/div[2]/div/div[2]/select/option[',i,']'))  
  secaoi[[1]]$clickElement()
  pesquisar[[1]]$clickElement()
  
  remDr$getPageSource()[[1]] %>%
    read_html() %>%
    html_nodes(.,"table")  %>%
    html_table(fill=FALSE) -> tab
}


lapply()

teste <- bind_rows(tab,setNames(rev(data2)),names(data2))


data2=vector("list",length(grep(pattern = "partido",x = tab)))
d=1

for(i in grep(pattern = "partido", x = tab)){
  data2[[d]] <- tab[[i]]
  d=d+1
  ##write.table(tab, 
    ##          "teste.csv", 
      ##        sep = ";", 
        ##      row.names = FALSE,
          ##    append = FALSE)
  
}


  write.csv(data2[[i]],paste0("teste",i,".csv"))

str(data2[[i]])
  


tidyr::gather(data = data2[[2]],key=grep("partido",colnames(data2[[2]]),nome, 1:3))

rbind_list(data2,)


write.table(data2,file = "teste.csv")
  data2[[2]] %>%
  spread(key = partido,teste)





remDr$server$stop()
gc(reset=TRUE)
rm(list=ls())
