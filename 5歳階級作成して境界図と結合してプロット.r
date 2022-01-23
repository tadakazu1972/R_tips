# 5�ΊK���쐬���ċ��E�}�ƌ������ăv���b�g
library(dplyr)
library(readr)
library(sf)
library(RColorBrewer)
library(classInt)

# �K�v�ȃt�@�C���Ǎ�
# eStat������{���擾
shape <- st_read("h27ka27.shp")
data1 <- read_csv("all.csv", locale=locale(encoding="SJIS"))

data2 <- data1 %>% filter(data1[, 5]=="�v")

# 60�Έȏ�5�ΊK���̃J�������f�[�^�t���[���̍Ō���ɒǉ�
data2 <- data2 %>% mutate('60-64��' = select(.,c(69,70,71,72,73)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('65-69��' = select(.,c(74,75,76,77,78)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('70-74��' = select(.,c(79,80,81,82,83)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('75-79��' = select(.,c(84,85,86,87,88)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('80-84��' = select(.,c(89,90,91,92,93)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('85-89��' = select(.,c(94,95,96,97,98)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('90-94��' = select(.,c(99,100,101,102,103)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('95-99��' = select(.,c(104,105,106,107,108)) %>% rowSums(na.rm=TRUE))
# �F���P���ڂ��ˏo���邽��10�ΊK�����ǉ�
data2 <- data2 %>% mutate('60-69��' = select(.,c(69,70,71,72,73,74,75,76,77,78)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('70-79��' = select(.,c(79,80,81,82,83,84,85,86,87,88)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('80-89��' = select(.,c(89,90,91,92,93,94,95,96,97,98)) %>% rowSums(na.rm=TRUE))
data2 <- data2 %>% mutate('90-99��' = select(.,c(99,100,101,102,103,104,105,106,107,108)) %>% rowSums(na.rm=TRUE))
# 65�Έȏ�ςݏグ
data2 <- data2 %>% mutate('65�Έȏ�' = select(.,c(74:109)) %>% rowSums(na.rm=TRUE))
# 75�Έȏ�ςݏグ
data2 <- data2 %>% mutate('75�Έȏ�' = select(.,c(84:109)) %>% rowSums(na.rm=TRUE))

# �m�F�ł���悤��csv�����o���Ă���
write.csv(data2, "all_sum.csv")

# ���E�}�Ɠ���
data <- left_join(shape, data2, by=c("S_NAME"="�����ږ�"))

# �F�̐ݒ�
# �f�[�^�̋�؂��75�Έȏ���������̂�50�ŋ�؂��Ă݂�
# �傫���l�𖾂邭�A�������l���Â��������̂�rev()���g�p
temp = data2[,124]
colset <- temp %>% classIntervals(., 10, style="fixed", fixedBreaks=c(49,50,100,150,200,250,300,350,400,450,max(.))) %>% findColours(.,pal=rev(brewer.pal(10,"YlGnBu")))

colset <- classIntervals(data[,158], 10, style="fixed", fixedBreaks=c(49,50,100,150,200,250,300,350,400,450)) %>% findColours(.,pal=rev(brewer.pal(10,"YlGnBu")))

# �����@2:1914�����{�̂������s�̒����ڂ͈̔�
# 145:60-64�� - 158:75�Έȏ�
plot(data[2:1914, 145], col=colset)