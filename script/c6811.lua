--Scripted by Eerie Code
--Superheavy Samurai General Sango
function c6811.initial_effect(c)
	--Pendulum Summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--scale
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_LSCALE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c6811.slcon)
	e2:SetValue(4)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e3)
	--Chain Attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(6811,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BATTLED)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c6811.cacon)
	e4:SetOperation(c6811.caop)
	c:RegisterEffect(e4)
	--Draw
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(6811,1))
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1,6811)
	e5:SetCondition(c6811.drcon)
	e5:SetCost(c6811.drcost)
	e5:SetTarget(c6811.drtg)
	e5:SetOperation(c6811.drop)
	c:RegisterEffect(e5)
end

function c6811.slcon(e)
	return Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end

function c6811.cacon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:IsStatus(STATUS_OPPO_BATTLE) and d:IsControler(tp) then a,d=d,a end
	if a:IsSetCard(0x9a)
		and not a:IsStatus(STATUS_BATTLE_DESTROYED) and d:IsStatus(STATUS_BATTLE_DESTROYED) then
		e:SetLabelObject(a)
		return true
	else return false end
end
function c6811.caop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsFaceup() and tc:IsControler(tp) and tc:IsRelateToBattle() and tc:IsChainAttackable() then
		Duel.ChainAttack()
	end
end

function c6811.drcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c6811.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x9a) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,2,nil,0x9a)
	Duel.Release(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c6811.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	local dc=e:GetLabel()
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dc)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dc)
end
function c6811.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end