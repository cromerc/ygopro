--デンジャラス・キャニオン
function c100000383.initial_effect(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_REPEAT)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c100000383.target)
	e1:SetOperation(c100000383.activate)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_REPEAT)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100000383.target2)
	e2:SetOperation(c100000383.activate)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_REPEAT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetTarget(c100000383.target)
	e3:SetOperation(c100000383.activate)
	c:RegisterEffect(e3)
end
function c100000383.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c100000383.target(e,tp,eg,ep,ev,re,r,rp,chk)	
	local tc=eg:GetFirst()
	if chk==0 then return c100000383.filter(tc) end
	Duel.SetTargetPlayer(ep)
	Duel.SetTargetParam(200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,200)
end
function c100000383.activate(e,tp,eg,ep,ev,re,r,rp)	
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000383.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(ep)
	Duel.SetTargetParam(200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,200)
end
