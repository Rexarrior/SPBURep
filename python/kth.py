import random
def quick_get_kth(nums, fst, lst, k):
    if (k < 0 ):
       return None
    if (k == 0):
        mine = nums[fst]
        for i in range(fst + 1, lst):
            if nums[i] < mine:
                mine = nums[i]
        return mine
 
    i, j = fst, lst
    
    pivot = nums[int((fst + lst) / 2)]


    while i <= j:
        while nums[i] < pivot: i += 1
        while nums[j] > pivot: j -= 1
        if i <= j:
            nums[i], nums[j] = nums[j], nums[i]
            i, j = i + 1, j - 1
   
    pivot_num = nums.index(pivot, fst, lst + 1) 

    if ( (pivot_num - fst) == k ):
        return pivot

    if pivot_num > k:
        return quick_get_kth(nums, fst , pivot_num , k)
    else:
        return quick_get_kth(nums, pivot_num , lst, k - pivot_num )






def get_kth(data, k):
    return quick_get_kth(data, 0, len(data) -1, k - 1 )
  

print(get_kth([0,1,2,3,4,5], 3))
print(get_kth([1,0,8,9,5,7], 3))
print(get_kth([1,0,8,9,5,7], 5))
print(get_kth([1,0,8,9,5,7], 1))