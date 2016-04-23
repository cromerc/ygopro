--Unbrekeable Spirit
function c13700021.initial_effect(c)
	--Generic Synchron
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(20932152)
	c:RegisterEffect(e3)	
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c13700021.spcost)
	e1:SetTarget(c13700021.sptg)
	e1:SetOperation(c13700021.spop)
	c:RegisterEffect(e1)
end
function c13700021.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c13700021.filter(c,e,tp)
	local lv=c:GetLevel()
	return  c:IsSetCard(0x43) and c:IsType(TYPE_MONSTER) and not c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and Duel.IsExistingMatchingCard(c13700021.filter2,tp,LOCATION_EXTRA,0,1,nil,lv+e:GetHandler():GetLevel(),c:GetCode(),e,tp)
end
function c13700021.filter2(c,lv,code,e,tp)
	return c:GetLevel()==lv
end
function c13700021.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c13700021.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c13700021.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sm=Duel.SelectTarget(tp,c13700021.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c13700021.spop(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c13700021.synlimit)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e2)	
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		local mg=Group.CreateGroup()
		mg:AddCard(tc)
		mg:AddCard(e:GetHandler())		
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
		Duel.Remove(mg,POS_FACEUP,REASON_COST)
		end
	end
end
function c13700021.synlimit(e,c)
	if not c then return false end
	return not c:IsSetCard(0x100)
end
