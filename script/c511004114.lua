--Volcanic Mine
--scripted by:urielkama
function c511004114.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCost(c511004114.cost)
e1:SetTarget(c511004114.tg)
e1:SetOperation(c511004114.op)
c:RegisterEffect(e1)
end
function c511004114.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c511004114.negfilter)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511004114.negfilter)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c511004114.negfilter(e,c)
	return c:IsType(TYPE_MONSTER+TYPE_EFFECT) and (c:IsFaceup() or c:IsFacedown())
end
function c511004114.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511004107,0,0,1000,1000,1,RACE_PYRO,ATTRIBUTE_FIRE) end
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c511004114.op(e,tp,eg,ep,ev,re,r,rp)
local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(1-tp,511004107,0,0,1000,1000,1,RACE_PYRO,ATTRIBUTE_FIRE) then return end
	local fid=e:GetHandler():GetFieldID()
	local g=Group.CreateGroup()
	for i=1,ft do
		local token=Duel.CreateToken(1-tp,511004107)
		Duel.SpecialSummonStep(token,0,1-tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		token:RegisterFlagEffect(511004114,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		g:AddCard(token)
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(g)
	e1:SetCondition(c511004114.descon)
	e1:SetOperation(c511004114.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511004114.desfilter(c,fid)
	return c:GetFlagEffectLabel(511004114)==fid
end
function c511004114.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511004114.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511004114.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511004114.desfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
end