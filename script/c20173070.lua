--Final Attack Orders
function c20173070.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c20173070.target)
	e1:SetOperation(c20173070.operation)
	c:RegisterEffect(e1)
	--Pos Change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_POSITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(POS_FACEUP_ATTACK)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	c:RegisterEffect(e3)
	end
function c20173070.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return  Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>2 and  Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(20173070,0))
	local g1=Duel.SelectTarget(tp,nil,tp,LOCATION_DECK,0,3,3,nil)
	if g1:GetCount()<3 then return end
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(20173070,0))
	local g2=Duel.SelectTarget(1-tp,nil,1-tp,LOCATION_DECK,0,3,3,nil)
	if g2:GetCount()<3 then return end
	g1:Merge(g2)	
	end
function c20173070.operation(e,tp,eg,ep,ev,re,r,rp)	
local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
local g1=g:Filter(Card.IsControler,nil,tp)
local g2=g:Filter(Card.IsControler,nil,1-tp)
local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,LOCATION_DECK)
if g1:GetCount()>2 and g2:GetCount()>2 then
Duel.DisableShuffleCheck()
Duel.SendtoHand(g,nil,REASON_EFFECT)
Duel.DiscardDeck(tp,dcount,REASON_EFFECT)
Duel.DiscardDeck(1-tp,dcount,REASON_EFFECT)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
Duel.SendtoDeck(g1,nil,1,REASON_EFFECT)
Duel.SortDecktop(tp,tp,3)
Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TODECK)
Duel.SendtoDeck(g2,nil,1,REASON_EFFECT)
Duel.SortDecktop(1-tp,1-tp,3)
end
end