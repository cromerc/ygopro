--No.25 重装光学撮影機フォーカス・フォース (Anime)
function c511010025.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010025,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511010025.condition)
	e1:SetCost(c511010025.cost)
	e1:SetTarget(c511010025.target)
	e1:SetOperation(c511010025.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010025.indes)
	c:RegisterEffect(e3)
	if not c511010025.global_check then
		c511010025.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010025.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010025.xyz_number=25
function c511010025.condition(e,tp,eg,ep,ev,re,r,rp)
  local c=e:GetHandler()
  if ep==tp or c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
  return re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c511010025.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local g=Duel.SetTargetCard(re:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end
function c511010025.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.NegateActivation(ev)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
	end
end

function c511010025.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,64554883)
	Duel.CreateToken(1-tp,64554883)
end
function c511010025.indes(e,c)
return not c:IsSetCard(0x48)
end