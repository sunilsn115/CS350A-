declare 
fun {ReverseList2 L} 
	local ReverseAux in 
		fun {ReverseAux Remainder Partial} 
			case Remainder 
			of nil then Partial 
			[] H|T then {ReverseAux T H|Partial}
			end 
		end 
		{ReverseAux L nil} 
	end 
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				   %%%%%%%%%%%%Part 1.1%%%%%%%%%%%%%%%
declare
fun {Take Xs N}
   local Take_tail in
      fun {Take_tail Xs N A}
	 if 0>=N
	 then A
	 else
	    case Xs
	    of nil
	    then A
	    [] H|T then {Take_tail T N-1 H|A}
	    end
	 end
      end
      {ReverseList2 {Take_tail Xs N nil}}
   end
end
				   %%%%%%%%%%%%Part 1.2%%%%%%%%%%%%%%%
declare
fun {Last Xs N}
   local Last_tail in
      fun {Last_tail Xs N A}
	 if 0>=N
	 then A
	 else
	    case Xs
	    of nil
	    then A
	    [] H|T then {Last_tail T N-1 H|A}
	    end
	 end
      end
      {Last_tail {ReverseList2 Xs} N nil}
   end
end
				   %%%%%%%%%%%%Part 1.3%%%%%%%%%%%%%%%
declare
fun {Merge A B}
   local Merge_tail in
      fun {Merge_tail A B C}
	 case A
	 of nil
	 then
	    case B
	    of nil
	    then C
	    [] H|T then {Merge_tail A T H|C}
	    end
	 else
	    case B
	    of nil
	    then {Merge_tail A.2 B A.1|C}
	    else
	    if A.1>B.1
	    then {Merge_tail A B.2 B.1|C}
	    else
	       {Merge_tail A.2 B A.1|C}
	    end
	    end
	 end
      end
      {ReverseList2 {Merge_tail A B nil}}
   end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				   %%%%%%%%%%%%Part 2.1%%%%%%%%%%%%%%%
declare
fun {ZipWith Xs Ys BinOp}
   case Xs
   of nil then nil
   else
      case Ys
      of nil then nil
      [] H|T then {BinOp Xs.1 H}|{ZipWith Xs.2 T BinOp}
      end
   end
end
				   %%%%%%%%%%%%Part 2.2%%%%%%%%%%%%%%%
declare
fun {New_Map L F}
   case L
   of nil then nil
   [] H|T then {FoldR [H] fun {$ X Y} {F X} end 1}|{New_Map T F}
   end
end
				   %%%%%%%%%%%%Part 2.3%%%%%%%%%%%%%%%
declare
fun {My_FoldL F L Identity}
   case L
   of nil then Identity
   [] H|T then {F {My_FoldL F T Identity} H} 
   end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				   %%%%%%%%%%%%Part 3.1%%%%%%%%%%%%%%%
declare
fun {Sin X}
   fun lazy {Sin_Exp X A B}
      if A==1
      then X*B|{Sin_Exp X A+2 X}
      else
	 (~1.0*B*X*X)/{IntToFloat A*(A-1)}|{Sin_Exp X A+2 (~1.0*B*X*X)/{IntToFloat A*(A-1)}}
      end
   end
in
   try  {Sin_Exp {IntToFloat X} 1 1.0}
   catch
      error(...) then {Sin_Exp X 1 1.0}
   end   
end
				   %%%%%%%%%%%%Part 3.2%%%%%%%%%%%%%%%
declare
fun {Approximate S Epsilon}
    local Approx in
      fun {Approx S Epsilon X}
    case S
    of nil then 0.0
    else
      if X==1
      then S.1+{Approx S.2 Epsilon X+1}
      else
        if {Number.abs Epsilon} >= {Number.abs S.1}
        then S.1
        else
          S.1+{Approx S.2 Epsilon X+1}
        end
      end
    end
      end
      {Approx S Epsilon 1}
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Question 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
declare
fun {Diagonal M}
   local Row Column in
      fun {Row X I J}
	 case X
	 of nil
	 then true
	 [] H|T  then if J==I then {Row T I J+1} elseif H==0 then {Row T I J+1} else false end
	 end
      end
      fun {Column Y I}
	 case Y
	 of nil then true
	 [] H|T then if {Row H I 1} then {Column T I+1} else false end
	 end
      end
      {Column M 1}
   end
end
