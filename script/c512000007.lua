--Underworld Circle
function c512000007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c512000007.target)
	e1:SetOperation(c512000007.activate)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(512000007,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetTarget(c512000007.drtg)
	e2:SetOperation(c512000007.drop)
	c:RegisterEffect(e2)
end
function c512000007.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c512000007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c512000007.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_DECK+LOCATION_HAND,1,nil) end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local tg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local sg=Duel.GetMatchingGroup(c512000007.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_DECK+LOCATION_HAND,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,tg:GetCount(),0,0)
end
function c512000007.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c512000007.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_DECK+LOCATION_HAND,nil)
	local tg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	Duel.Destroy(tg,REASON_EFFECT)
--remove
local c=e:GetHandler()
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
e3:SetCode(EFFECT_TO_GRAVE_REDIRECT)
e3:SetRange(LOCATION_SZONE)
e3:SetTarget(c512000007.rmtarget)
e3:SetValue(LOCATION_REMOVED)
Duel.RegisterEffect(e3,tp,1-tp)
end
function c512000007.filt(c,e,tp)
return c:IsCanBeSpecialSummoned(e,0,tp,true,true) and c:IsType(TYPE_MONSTER) 
end
function c512000007.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then
		return Duel.IsExistingTarget(c512000007.filt,tp,LOCATION_GRAVE,0,1,nil,e,tp)
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingTarget(c512000007.filt,1-tp,LOCATION_GRAVE,0,1,nil,e,1-tp)
			and Duel.GetLocationCount(1-tp,LOCATION_MZONE,1-tp)>0
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectTarget(tp,c512000007.filt,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
	local og=Duel.SelectTarget(1-tp,c512000007.filt,1-tp,LOCATION_GRAVE,0,1,1,nil,e,1-tp)
	local sc=sg:GetFirst()
	local oc=og:GetFirst()
	local g=Group.FromCards(sc,oc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
	e:SetLabelObject(sc)
end
function c512000007.drop(e,tp,eg,ep,ev,re,r,rp)
	local sc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local oc=g:GetFirst()
	if oc==sc then oc=g:GetNext() end
	if sc:IsRelateToEffect(e) then
		Duel.SpecialSummonStep(sc,0,tp,tp,true,true,POS_FACEUP)
	end
	if oc:IsRelateToEffect(e) then
		Duel.SpecialSummonStep(oc,0,1-tp,1-tp,true,true,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c512000007.rmtarget(e,c)
	return not c:IsLocation(0x80) and not c:IsType(TYPE_SPELL+TYPE_TRAP)
end
