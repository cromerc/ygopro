--Number 7: Lucky Straight (anime)
function c511010007.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3)
	c:EnableReviveLimit()
	--atkup
		local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96864105,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010007.atkcost)
	e1:SetOperation(c511010007.atkop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010007.indes)
	c:RegisterEffect(e2)
	if not c511010007.global_check then
		c511010007.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010007.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010007.xyz_number=7
function c511010007.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010007.atkop(e,tp,eg,ep,ev,re,r,rp)
	local d1=Duel.TossDice(tp,1)
	local tc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetValue(d1*700)
	e:GetHandler():RegisterEffect(e1)
end
function c511010007.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,82308875)
	Duel.CreateToken(1-tp,82308875)
end
function c511010007.indes(e,c)
return not c:IsSetCard(0x48)
end