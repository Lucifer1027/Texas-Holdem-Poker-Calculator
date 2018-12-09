clear ALL;
%main function
%--------------------------------------------------------------------------
tic;
amount = 10000000;
numontable = 5*2+5;
for i = 1:amount
    cardvec = card_generator_main(numontable);
    FlushCounter(cardvec);
    Straight_Counter_main_1(cardvec);
    Cards_Counter(cardvec);
    per_printer(amount,i)
end
StraightCounterCaller(amount);
FlushCounterCaller(amount);
CardsCounterCaller(amount);
toc;
%--------------------------------------------------------------------------


%Subfunctions
%--------------------------------------------------------------------------

%Begin of Card Generator
%------------------------------------------------
function draw_vec =  card_generator_main(n)
card_vec = 1:52;
vec_main = zeros(1,n);
draw_vec = zeros(1,7);
for i = 1:n
    card_num = randi([1,53-i]);
    card_drawn = card_translator(card_vec(card_num));
    vec_main(i) = card_drawn;
    card_vec(card_num) = [];
end
draw_vec(1:5) = vec_main(1:5);
for i = 1:2
    ran = randi([6,n+1-i]);
    draw_vec(i+5) = vec_main(ran);
    vec_main(ran) = [];
end
end
function cardout = card_translator(cardin)
cardout = (floor(cardin/13)+1)*100 + rem(cardin,13)+1;
end
%------------------------------------------------
%End of Card Generator 2


%Begin of Percent Printer
%------------------------------------------------
function per_printer(amount,i)
if i == (amount/20)
    disp("5%");
elseif i == (amount/20)*2
    disp("10%");
elseif i == (amount/20)*3
    disp("15%");
elseif i == (amount/20)*4
    disp("20%");
elseif i == (amount/20)*5
    disp("25%");
elseif i == (amount/20)*6
    disp("30%");
elseif i == (amount/20)*7
    disp("35%");
elseif i == (amount/20)*8
    disp("40%");
elseif i == (amount/20)*9
    disp("45%");
elseif i == (amount/20)*10
    disp("50%");
elseif i == (amount/20)*11
    disp("55%");
elseif i == (amount/20)*12
    disp("60%");
elseif i == (amount/20)*13
    disp("65%");
elseif i == (amount/20)*14
    disp("70%");
elseif i == (amount/20)*15
    disp("75%");
elseif i == (amount/20)*16
    disp("80%");
elseif i == (amount/20)*17
    disp("85%");
elseif i == (amount/20)*18
    disp("90%");
elseif i == (amount/20)*19
    disp("95%");
elseif i == (amount/20)*20
    disp("100%");
end
end
%------------------------------------------------
%End of Percent Printer


%Begin of Straight Counter
%------------------------------------------------
function StraightCounterCaller(amount)
StraightCounterInitializer();
persistent count;
if isempty(count)
    count = 0;
end
count = count + 1;
countstraight = Straight_Counter_Branch()-count;
fprintf("Straight: %d %.2f%%\n",countstraight,(countstraight/amount)*100);
end
function StraightCounterInitializer()
clear StraightCounter;
end
function Straight_Counter_main_1(cardvec)
vec = zeros(1,7);
for i = 1:7
    vec(i) = rem(cardvec(i),100);
end
Straight_Counter_main_ace(vec);
end
function Straight_Counter_main_ace(vec1)
vec2 = vec1;
nvec = find(vec1 == 1);
if isempty(nvec) == 0
    for i = 1:length(nvec)
        vec2(nvec(i)) = 14;
    end
    Straight_Counter_main_2(vec2);
else
    Straight_Counter_main_2(vec1);
end
end
function Straight_Counter_main_2(cardvec)
univec = -ones(1,7);
univec(1:length(unique(cardvec))) = unique(cardvec);
cardvec = univec;
cardvec = sort(cardvec);
vecin(1:5) = cardvec(1:5);
output = Straight_Counter_main_3(vecin);
if output == 0
    vecin(1:5) = cardvec(2:6);
    output = Straight_Counter_main_3(vecin);
    if output == 0
        vecin(1:5) = cardvec(3:7);
        Straight_Counter_main_3(vecin);
    end
end
end
function output = Straight_Counter_main_3(cardvec)
output = 0;
minval = min(cardvec);
nvec = find(cardvec == minval);
n = nvec(1);
cardvec(n) = [];
if min(cardvec) == (minval + 1)
    minval = min(cardvec);
    nvec = find(cardvec == minval);
    n = nvec(1);
    cardvec(n) = [];
    if min(cardvec) == (minval + 1)
        minval = min(cardvec);
        nvec = find(cardvec == minval);
        n = nvec(1);
        cardvec(n) = []; 
        if min(cardvec) == (minval + 1)
            minval = min(cardvec);
            nvec = find(cardvec == minval);
            n = nvec(1);
            cardvec(n) = [];
            if cardvec == (minval + 1)
                Straight_Counter_Branch();
                output = 1;
            end
        end
    end
end
end
function output = Straight_Counter_Branch()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
%------------------------------------------------
%End of Flush Counter


%Begin of Flush Counter
%------------------------------------------------
function FlushCounterCaller(amount)
clear FiveFlushCounter;
persistent count;
if isempty(count)
    count = 0;
end
count = count + 1;
count5 = FiveFlushCounter()-count;
fprintf("Flush: %d %.2f%%\n",count5,(count5/amount)*100);
end
function FlushCounter(vec)
count1 = 0;
count2 = 0;
count3 = 0;
count4 = 0;
for i = 1:7
    if abs(vec(i)-100)<100
        count1 = count1 + 1;
    elseif abs(vec(i)-200)<100
        count2 = count2 + 1;
    elseif abs(vec(i)-300)<100
        count3 = count3 + 1;
    elseif abs(vec(i)-400)<100
        count4 = count4 + 1;
    end
end
if count1 >= 5 || count2 >= 5 || count3 >= 5 || count4 >= 5
    FiveFlushCounter();
end
end
function output = FiveFlushCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
%------------------------------------------------
%End of Flush Counter


%Begin of Full House Counter
%------------------------------------------------
function CardsCounterCaller(amount)
CardsCounterInitializer();
persistent count;
if isempty(count)
    count = 0;
end
count = count + 1;
count2 = TwoCardsCounter()-count;
count3 = ThreeCardsCounter()-count;
count4 = FourCardsCounter()-count;
count5 = TwoPairsCounter()-count;
count6 = FullHouseCounter()-count;
fprintf("Four of a kind: %d %.2f%%\n",count4,(count4/amount)*100);
fprintf("Full House: %d %.2f%%\n",count6,(count6/amount)*100);
fprintf("Three of a kind: %d %.2f%%\n",count3,(count3/amount)*100);
fprintf("Two pair: %d %.2f%%\n",count5,(count5/amount)*100);
fprintf("Pair: %d %.2f%%\n",count2,(count2/amount)*100);
end
function CardsCounterInitializer()
clear TwoCardsCounter;
clear ThreeCardsCounter;
clear FourCardsCounter;
clear TwoPairsCounter;
clear FullHouseCounter;
end
function output = Cards_Counter(card)
card1=0;card2=0;card3=0;card4=0;card5=0;card6=0;card7=0;
card8=0;card9=0;card10=0;card11=0;card12=0;card13=0;
for i = 1:7
    rmd = rem(card(i),100);
    if rmd == 1
        card1 = card1 + 1;
    elseif rmd == 2
        card2 = card2 + 1;
    elseif rmd == 3
        card3 = card3 + 1;
    elseif rmd == 4
        card4 = card4 + 1;
    elseif rmd == 5
        card5 = card5 + 1;
    elseif rmd == 6
        card6 = card6 + 1;
    elseif rmd == 7
        card7 = card7 + 1;
    elseif rmd == 8
        card8 = card8 + 1;
    elseif rmd == 9
        card9 = card9 + 1;
    elseif rmd == 10
        card10 = card10 + 1;
    elseif rmd == 11
        card11 = card11 + 1;
    elseif rmd == 12
        card12 = card12 + 1;
    elseif rmd == 13
        card13 = card13 + 1;
    end
end
cardnumvec = [card1 card2 card3 card4 card5 card6 card7 card8 card9 card10 card11 card12 card13];
if isempty(find(cardnumvec == 4)) ~= 1
    FourCardsCounter();
elseif isempty(find(cardnumvec == 3)) ~= 1
    ThreeCardsCounter();
    if isempty(find(cardnumvec == 2)) ~= 1
        FullHouseCounter();
    end
elseif isempty(find(cardnumvec == 2)) ~= 1
    if length(find(cardnumvec == 2)) == 1
        TwoCardsCounter();
    elseif length(find(cardnumvec == 2)) == 2
        TwoPairsCounter();
    end
else
    output = 0;
end
end
function output = TwoPairsCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
function output = FullHouseCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
function output = TwoCardsCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
function output = ThreeCardsCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
function output = FourCardsCounter()
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
output = count;
end
%------------------------------------------------
%--------------------------------------------------------------------------