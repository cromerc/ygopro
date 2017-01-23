--Number C1: Gate of Chaos Numeron - Shunya
function c511000277.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,4,c511000277.ovfilter,aux.Stringid(511000277,0),3,c511000277.xyzop)
	c:EnableReviveLimit()
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000277.descon)
	c:RegisterEffect(e1)
	--banish
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000277,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetLabel(0)
	e2:SetCondition(c511000277.bancon)
	e2:SetTarget(c511000277.bantg)
	e2:SetOperation(c511000277.banop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000277,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c511000277.spcon)
	e3:SetTarget(c511000277.sptg)
	e3:SetOperation(c511000277.spop)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511000277.indes)
	c:RegisterEffect(e4)
end
c511000277.xyz_number=1
function c511000277.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000275)
end
function c511000277.ovfilter(c)
	return c:IsFaceup() and c:IsCode(511000230)
end
function c511000277.xyzop(e,tp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000277.cfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(511000275) end
end
function c511000277.descon(e)
	return not Duel.IsEnvironment(511000275)
end
function c511000277.bancon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c511000277.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511000277.damfilter(c,e)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c511000277.banop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local chk=c:IsRelateToEffect(e)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local gd=Duel.GetMatchingGroup(c511000277.damfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local atk=0
	local bc=gd:GetFirst()
	while bc do
		atk=atk+bc:GetAttack()
		bc=gd:GetNext()
	end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if not chk then return end
	c:RegisterFlagEffect(511000277,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,1)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000277,3))
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetLabel(atk)
	e4:SetCondition(c511000277.damcon)
	e4:SetCost(c511000277.damcost)
	e4:SetTarget(c511000277.damtg)
	e4:SetOperation(c511000277.damop)
	c:RegisterEffect(e4)
end
function c511000277.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and tp==Duel.GetTurnPlayer() and c:GetFlagEffect(511000277)>0
end
function c511000277.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	c:ResetFlagEffect(511000277)
end
function c511000277.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000277.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000277.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1
end
function c511000277.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511000277.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511000277.indes(e,c)
	return not c:IsSetCard(0x48)
end
