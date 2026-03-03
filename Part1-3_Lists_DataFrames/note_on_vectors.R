# ====================================
# Time Series Analysis with R
# gwendolin.wilke@fhnw.ch
# This is a note on vectors in R.
# ==================================== 


# PROPERTY 1: A vector can only contain elements of the same type. 
#
#   - If you try to combine different types, R will coerce them to a common type. 
#   - In this example, the number 1 will be coerced to a character string "1" to 
#     match the type of "gwen".
#   - The result will be a vector of character strings:
c("gwen", 1) 

# PROPERTY 2: A vector cannot contain complex data structures.
#
#   - In the following example, we are trying to construct a vector that contains a list.
#     A list is a complex data structure. 
#     Instead of constructing the vector that we asked for, R constructs a list
#     to accomodate the complex data structure:
c(list("Ada","gwen"), "Arpad") # 

