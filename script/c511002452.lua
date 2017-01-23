--ガーディアン・デスサイス
function c511002452.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--summon limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(18175965,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetRange(LOCATION_HAND+LOCATION_DECK)
	e4:SetCondition(c511002452.spcon)
	e4:SetTarget(c511002452.sptg)
	e4:SetOperation(c511002452.spop)
	c:RegisterEffect(e4)
	--equip
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(18175965,1))
	e5:SetCategory(CATEGORY_EQUIP)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetCondition(c511002452.eqcon)
	e5:SetTarget(c511002452.eqtg)
	e5:SetOperation(c511002452.eqop)
	c:RegisterEffect(e5)
	--disable summon
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_SUMMON)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(1,0)
	c:RegisterEffect(e6)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e7)
	--destroy
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetCategory(CATEGORY_DESTROY)
	e8:SetDescription(aux.Stringid(39765958,0))
	e8:SetRange(LOCATION_MZONE)
	e8:SetCondition(c511002452.descon)
	e8:SetTarget(c511002452.destg)
	e8:SetOperation(c511002452.desop)
	c:RegisterEffect(e8)
	--Destroy replace
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_DESTROY_REPLACE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTarget(c511002452.desreptg)
	c:RegisterEffect(e9)
end
function c511002452.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:GetPreviousControler()==tp
		and c:IsReason(REASON_DESTROY) and c:IsCode(34022290)
end
function c511002452.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002452.cfilter,1,nil,tp)
end
function c511002452.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,1,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511002452.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,1,tp,tp,true,false,POS_FACEUP_DEFENSE)>0 then
		c:CompleteProcedure()
	end
end
function c511002452.filter(c,ec)
	return c:IsCode(81954378) and c:CheckEquipTarget(ec)
end
function c511002452.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c511002452.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511002452.filter,tp,LOCATION_DECK,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_DECK)
end
function c511002452.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(18175965,3))
	local g=Duel.SelectMatchingCard(tp,c511002452.filter,tp,LOCATION_DECK,0,1,1,nil,c)
	if g:GetCount()>0 then
		Duel.Equip(tp,g:GetFirst(),c)
	end
end
function c511002452.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c511002452.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511002452.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511002452.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	return true
end
