--オレイカルコス・デウテロス
function c110000100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c110000100.atcon)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)	
	e2:SetTarget(c110000100.target)
	e2:SetOperation(c110000100.operation)
	c:RegisterEffect(e2)
	--DESTROY
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c110000100.atkcon)
	e3:SetCost(c110000100.cost)
	e3:SetTarget(c110000100.atktg)
	e3:SetOperation(c110000100.atkop)
	c:RegisterEffect(e3)
	--selfdes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c110000100.sdcon2)
	e4:SetOperation(c110000100.sdop)
	c:RegisterEffect(e4)
end
function c110000100.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(110000100)==0
end
function c110000100.sdop(e,tp,eg,ep,ev,re,r,rp)	
	e:GetHandler():CopyEffect(48179391,RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterFlagEffect(110000100,RESET_EVENT+0x1fe0000,0,1)
end
function c110000100.atcon(e)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)	
	return tc~=nil and tc:IsFaceup() and tc:IsCode(48179391)
end
function c110000100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 end
	Duel.SetTargetPlayer(tp)
	local rec=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*500
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c110000100.operation(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*500
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,rec,REASON_EFFECT)
end
function c110000100.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c110000100.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c110000100.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c110000100.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToEffect(e) and tc:IsAttackable() and Duel.NegateAttack() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end