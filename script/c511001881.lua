--Xyz Meteor
function c511001881.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001881.target)
	e1:SetOperation(c511001881.operation)
	c:RegisterEffect(e1)
end
function c511001881.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001881.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001881.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001881.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001881.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001881.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_PIERCE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(49328340,0))
		e2:SetCategory(CATEGORY_DRAW)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
		e2:SetCode(EVENT_BATTLE_DAMAGE)
		e2:SetCondition(c511001881.drcon)
		e2:SetTarget(c511001881.drtg)
		e2:SetOperation(c511001881.drop)
		e2:SetLabelObject(tc)
		Duel.RegisterEffect(e2,tp)
		tc:RegisterFlagEffect(511001881,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c511001881.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return bc and bc:IsDefensePos() and tc:GetFlagEffect(511001881)>0 and e:GetLabelObject()==tc
end
function c511001881.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001881.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
