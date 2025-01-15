# extact coordantes and mke new .csv file
ALL <- read.csv('./Data/tidy_data/tidy_polypen_D1_D2.csv')

a <-unique(ALL[, c("ID", "Coordinates")])
b <-unique(ALL[, c("ID",'Location', 'Tapping', 'Tree_num', 'C_pos.', "Coordinates", "Tree_ID", 'lat','lon')])

write.csv(b, './Data/tidy_data/tree_coord.csv')
