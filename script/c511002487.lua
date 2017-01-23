--幻奏の華歌聖ブルーム・ディーヴァ
function c511002487.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002487.mfilter,aux.FilterBoolFunction(Card.IsFusionSetCard,0x9b),true)
	--effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c511002487.condition)
	e1:SetOperation(c511002487.operation)
	c:RegisterEffect(e1)
end
function c511002487.mfilter(c)
	return c:IsFusionSetCard(0x209b) or c:IsCode(14763299) or c:IsCode(62895219)
end
function c511002487.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bit.band(bc:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and bc:IsControler(1-tp)
end
function c511002487.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
		e2:SetValue(1)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e2)
		if bc:IsRelateToBattle() then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e3:SetCode(EVENT_BATTLED)
			e3:SetOperation(c511002487.desop)
			e3:SetReset(RESET_PHASE+PHASE_DAMAGE)
			bc:RegisterEffect(e3)
		end
	end
end
function c511002487.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
