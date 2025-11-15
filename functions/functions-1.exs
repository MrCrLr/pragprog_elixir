iex(14)> list_concat = fn [a,c],[b,d] -> [a,c] ++ [b,d] end
#Function<41.113135111/2 in :erl_eval.expr/6>
iex(15)> list_concat.(list1,list2)
[1, 2, 3, 4]

iex(16)> sum = fn (w, x, y) -> w + x + y end
#Function<40.113135111/3 in :erl_eval.expr/6>
iex(17)> a = 1
1
iex(18)> b = 2
2
iex(19)> c = 3
3
iex(20)> sum.(a, b, c)
6

iex(21)> pair_tuple_to_list = fn ({i, j}) -> [i, j] end
#Function<42.113135111/1 in :erl_eval.expr/6>
iex(22)> tuple1 = {1234, 5678}
{1234, 5678}
iex(23)> pair_tuple_to_list.(tuple1)
[1234, 5678]
