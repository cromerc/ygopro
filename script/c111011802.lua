--ランクアップ・アドバンテージ
function c111011802.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(111011802,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c111011802.drcon)
	e2:SetTarget(c111011802.drtg)
	e2:SetOperation(c111011802.drop)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c111011802.discon1)
	e3:SetOperation(c111011802.disop1)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)	
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetRange(LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_ONFIELD)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetOperation(c111011802.spop)
	c:RegisterEffect(e4)
end
function c111011802.drfilter(c)
	return c:GetSummonType()==SUMMON_TYPE_XYZ
end
function c111011802.drcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return eg:IsExists(c111011802.drfilter,1,nil) and rc:IsSetCard(0x95)
end
function c111011802.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c111011802.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c111011802.discon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():GetFlagEffect(111011802)~=0
	and Duel.GetAttacker():GetControler()==tp
end
function c111011802.disop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	c:CreateRelation(tc,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e1:SetCondition(c111011802.discon2)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e2:SetOperation(c111011802.disop2)
	e2:SetLabelObject(tc)
	c:RegisterEffect(e2)
end
function c111011802.discon2(e)
	return e:GetOwner():IsRelateToCard(e:GetHandler())
end
function c111011802.disop2(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if loc==LOCATION_MZONE and re:GetHandler()==e:GetLabelObject() then
		Duel.NegateEffect(ev)
	end
end
function c111011802.spop(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	local rc=re:GetHandler()
	if eg:GetCount()==1  and tg:GetSummonType()==SUMMON_TYPE_XYZ
	and rc:IsSetCard(0x95) then
		tg:RegisterFlagEffect(111011802,RESET_EVENT+0x1fe0000,0,1) 	
	end
end
