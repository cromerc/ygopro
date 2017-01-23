--Djinn Cycle
--NOTE: Edit out, remove comments when Trigger is already handled by YGoPro Percy
function c511002561.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	--e1:SetCategory(CATEGORY_DAMAGE)
	--e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	--e1:SetDescription(aux.Stringid(11287364,0))
	--e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	--Trigger not allowed on Xyz Material
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c511002561.damcon)
	--e1:SetTarget(c511002561.damtg)
	e1:SetOperation(c511002561.damop)
	c:RegisterEffect(e1)
end
function c511002561.damcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_XYZ
end
function c511002561.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,400)
end
function c511002561.damop(e,tp,eg,ep,ev,re,r,rp)
	--local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	--Duel.Damage(p,d,REASON_EFFECT)
	--replacement for Trigger
	local rc=e:GetHandler():GetReasonCard()
	Duel.Hint(HINT_CARD,0,511002561)
	Duel.Damage(1-rc:GetControler(),400,REASON_EFFECT)
end
