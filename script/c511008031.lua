--Ray of Hope (ZEXAL)
--	by Snrk
local self=c511008031
local sid=511008031

function self.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(self.cd)
	e1:SetOperation(self.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(self.op2)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end

function self.cf(c,p) return c:IsControler(p) and c:IsType(TYPE_MONSTER) and c:IsOnField() end

function self.cd(e,tp,eg,ep,ev)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	local fc=Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_ONFIELD,0,nil,TYPE_MONSTER)
	e:SetLabelObject(tg)
	return ex and tg~=nil and tg:FilterCount(self.cf,nil,tp)==fc
end
function self.op(e,tp,eg,ep,ev,re)
	local tg=e:GetLabelObject():Filter(self.cf,nil,tp)
	if tg:GetCount()<=0 then return end
	local tc=tg:Select(tp,1,1,nil):GetFirst()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetValue(function (p) return Duel.GetFlagEffect(tp,sid)~=0 end,tp)
	e1:SetReset(RESET_CHAIN)
	tc:RegisterEffect(e1)
	e:SetLabel(re:GetHandler():GetFieldID())
	Duel.RegisterFlagEffect(tp,sid,RESET_CHAIN,0,1)
end
function self.op2(e,tp,eg,ep,ev,re)
	if e:GetLabel()==1 then Duel.ResetFlagEffect(tp,sid) end
	if e:GetLabelObject():GetLabel()==re:GetHandler():GetFieldID() then e:SetLabel(1) end
end