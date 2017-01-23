--Fairy Rail
function c511009329.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c511009329.cost)
	e1:SetCondition(c511009329.con)
	e1:SetTarget(c511009329.tg)
	e1:SetOperation(c511009329.activate)
	c:RegisterEffect(e1)
end
--OCG Fairy collection
c511009329.collection={
[51960178]=true; 	
[25862681]=true; 	
[23454876]=true; 	
[90925163]=true; 	
[48742406]=true; 	
[51960178]=true; 	
[45939611]=true; 	
[20315854]=true; 	
[1761063]=true; 	
[6979239]=true; 	
[55623480]=true; 	
[42921475]=true; 	
}
function c511009329.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,0,2,REASON_COST) end
	Duel.RemoveOverlayCard(tp,1,0,2,2,REASON_COST)
end
function c511009329.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511009329.filter(c)
	return c:IsFaceup() and  (c:IsSetCard(0x412) or c511009329.collection[c:GetCode()])
end
function c511009329.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511009329.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,c511009329.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetParam(Duel.GetBattleDamage(tp))
	
	
end
function c511009329.activate(e,tp,eg,ep,ev,re,r,rp)
	local sc=Duel.GetFirstTarget()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	-- Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	-- local g=Duel.SelectMatchingCard(tp,c511009329.filter,tp,LOCATION_MZONE,0,1,1,nil,pos)
	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(d)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	sc:RegisterEffect(e1)
	-- If that monster attacks, it is changed to Defense Position at the end of damage calculation.
	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511009329.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511009329.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
