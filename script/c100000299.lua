--虚無王アンフォームド・ヴォイド
function c100000299.initial_effect(c)
	--synchro summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,4),3)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000299,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+0x1c0)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c100000299.cost)
	e1:SetCondition(c100000299.con)
	e1:SetOperation(c100000299.op)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetOperation(c100000299.soop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_INITIAL)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000299.scon)
	e3:SetOperation(c100000299.sop)
	c:RegisterEffect(e3)
end
function c100000299.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100000299.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000299.filter,tp,0,LOCATION_MZONE,1,nil)
	and Duel.GetTurnPlayer()~=tp
end
function c100000299.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c100000299.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c100000299.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local atk=0
		local tc=g:GetFirst()
		while tc do
			atk=atk+tc:GetAttack()
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c100000299.scon(e)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	local bc=c:GetBattleTarget()
	if not bc then return end
	local bct=0
	if bc:GetPosition()==POS_FACEUP_ATTACK then
		bct=bc:GetAttack()
	else bct=bc:GetDefence()+1 end
	return c:IsRelateToBattle() and c:GetPosition()==POS_FACEUP_ATTACK 
	 and atk>=bct and not bc:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c100000299.sop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	Duel.Destroy(bc,REASON_BATTLE)
	bc:SetStatus(STATUS_BATTLE_DESTROYED,true)
end
function c100000299.soop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetOperation(c100000299.resetop)
		e2:SetLabelObject(e1)
		bc:RegisterEffect(e2)
	end
end
function c100000299.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():Reset()
	e:Reset()
end
