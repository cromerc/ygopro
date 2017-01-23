--Guts Master Heat
function c511002677.initial_effect(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002677.sptg)
	e2:SetOperation(c511002677.spop)
	c:RegisterEffect(e2)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002677.descon)
	e1:SetTarget(c511002677.destg)
	e1:SetOperation(c511002677.desop)
	c:RegisterEffect(e1)
end
function c511002677.spfilter(c,e,tp)
	return c:IsSetCard(0x21c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002677.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002677.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002677.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002677.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511002677.descon(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return e:GetHandler()~=bt and bt:IsFaceup() and bt:IsSetCard(0x21c) and bt:IsAttackPos() and bt:IsControler(tp)
end
function c511002677.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c511002677.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetCondition(c511002677.descon2)
	e5:SetOperation(c511002677.desop2)
	tc:RegisterEffect(e5)
end
function c511002677.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle()
end
function c511002677.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511002677)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
