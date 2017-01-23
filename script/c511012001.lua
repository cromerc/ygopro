--オッドアイズ・ペンデュラム・ドラゴン
--fixed by MLD
function c511012001.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--cannot destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(511012000)
	e1:SetRange(LOCATION_PZONE)
	c:RegisterEffect(e1)
	--reduce
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16178681,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c511012001.rdcon)
	e2:SetOperation(c511012001.rdop)
	c:RegisterEffect(e2)
	--double
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c511012001.damcon)
	e4:SetOperation(c511012001.damop)
	c:RegisterEffect(e4)
end
function c511012001.rdcon(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(511012001)>0 then return false end
	local tc=Duel.GetAttacker()
	if tc:IsControler(1-tp) then tc=Duel.GetAttackTarget() end
	return ep==tp and tc and tc:IsType(TYPE_PENDULUM) and Duel.GetBattleDamage(tp)>0
end
function c511012001.rdop(e,tp,eg,ep,ev,re,r,rp)
	local pc1=e:GetHandler()
	local pc2=Duel.GetFieldCard(tp,LOCATION_SZONE,13-pc1:GetSequence())
	local g
	if pc2 and pc2:IsHasEffect(511012000) and pc2:GetFlagEffect(511012001)==0 then
		g=Group.FromCards(pc1,pc2)
	else
		g=Group.FromCards(pc1)
	end
	if Duel.GetFlagEffect(tp,511012001)==0 and Duel.SelectYesNo(tp,aux.Stringid(16178681,2)) then
		if g:GetCount()>1 then g=g:Select(tp,1,1,nil) end
		Duel.HintSelection(g)
		Duel.Hint(HINT_CARD,0,511012001)
		local tc=g:GetFirst()
		Duel.RegisterFlagEffect(tp,511012001,RESET_PHASE+PHASE_DAMAGE,0,1)
		tc:RegisterFlagEffect(511012001,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		Duel.ChangeBattleDamage(tp,0)
	end
end
function c511012001.damcon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return ep~=tp and bc and bc:IsLevelAbove(5) and bc:IsControler(1-tp)
end
function c511012001.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end
