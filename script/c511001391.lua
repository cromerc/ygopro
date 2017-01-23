--ユベル
function c511001391.initial_effect(c)
	--battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetCondition(c511001391.condition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_RELEASE+CATEGORY_DESTROY)
	e4:SetDescription(aux.Stringid(78371393,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCondition(c511001391.descon)
	e4:SetTarget(c511001391.destg)
	e4:SetOperation(c511001391.desop)
	c:RegisterEffect(e4)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(78371393,3))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetCondition(c511001391.spcon)
	e5:SetTarget(c511001391.sptg)
	e5:SetOperation(c511001391.spop)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c511001391.condition(e)
	return e:GetHandler():IsAttackPos()
end
function c511001391.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001391.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsLocation(LOCATION_DECK) end
	if not Duel.CheckReleaseGroup(tp,nil,1,nil) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	end
end
function c511001391.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	if Duel.CheckReleaseGroup(tp,Card.IsReleasableByEffect,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(78371393,2)) then
		local g=Duel.SelectReleaseGroup(tp,Card.IsReleasableByEffect,1,1,nil)
		Duel.Release(g,REASON_EFFECT)
	else Duel.Destroy(c,REASON_EFFECT) end
end
function c511001391.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re~=e:GetLabelObject()
end
function c511001391.filter(c,e,tp)
	return c:IsCode(4779091) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
		and (not c:IsLocation(LOCATION_GRAVE) or not c:IsHasEffect(EFFECT_NECRO_VALLEY))
end
function c511001391.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c511001391.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001391.filter,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
		Duel.ShuffleDeck(tp)
	end
end
