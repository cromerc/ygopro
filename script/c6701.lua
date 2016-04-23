--Scripted by Eerie Code
--Erebus the Netherworld Monarch
function c6701.initial_effect(c)
	--Summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6701,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c6701.otcon)
	e1:SetOperation(c6701.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e2)
	--Shuffle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6701,1))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c6701.tdcon)
	e3:SetTarget(c6701.tdtg)
	e3:SetOperation(c6701.tdop)
	c:RegisterEffect(e3)
	--Recover
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6701,2))
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetHintTiming(0,TIMING_MAIN_END)
	e4:SetCountLimit(1)
	e4:SetCost(c6701.thcost)
	e4:SetTarget(c6701.thtg)
	e4:SetOperation(c6701.thop)
	c:RegisterEffect(e4)
end

function c6701.otfilter(c)
	return bit.band(c:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE
end
function c6701.otcon(e,c)
	if c==nil then return true end
	local mg=Duel.GetMatchingGroup(c6701.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	return c:GetLevel()>6 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.GetTributeCount(c,mg)>0
end
function c6701.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local mg=Duel.GetMatchingGroup(c6701.otfilter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end

function c6701.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE
end
function c6701.tdfil1(c)
	return c:IsSetCard(0xbe) and c:IsAbleToGraveAsCost()
end
function c6701.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		return Duel.GetMatchingGroup(c6701.tdfil1,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetClassCount(Card.GetCode)>=2 and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE,1,nil)
	end
end
function c6701.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c6701.tdfil1,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local cg=Group.CreateGroup()
	for i=1,2 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g1:Select(tp,1,1,nil)
		g1:Remove(Card.IsCode,nil,sg:GetFirst():GetCode())
		cg:Merge(sg)
	end
	if Duel.SendtoGrave(cg,REASON_COST)>0 then
		local g2=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD+LOCATION_HAND+LOCATION_GRAVE,1,1,nil)
		if g2:GetCount()>0 then Duel.SendtoDeck(g2,nil,2,REASON_EFFECT) end
	end
end

function c6701.thfil1(c)
	return c:IsSetCard(0xbe) and c:IsDiscardable()
end
function c6701.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6701.thfil1,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c6701.thfil1,1,1,REASON_COST+REASON_DISCARD)
end
function c6701.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttackAbove(2400) and c:GetDefence()==1000 and c:IsAbleToHand()
end
function c6701.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6701.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c6701.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c6701.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c6701.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end