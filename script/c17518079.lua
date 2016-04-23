--Rebellion
function c17518079.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c17518079.target)
	e1:SetOperation(c17518079.activate)
	c:RegisterEffect(e1)
	end
	
function c17518079.filter(c)
	return c:IsControlerCanBeChanged() and c:IsFaceup()
end
function c17518079.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c17518079.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17518079.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c17518079.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c17518079.activate(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e)  then
	--Take Control during Battle Phase
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	e1:SetOperation(c17518079.ctlop)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(tp)
	tc:RegisterEffect(e1,true)
	--Card is considered Opponent's Monster
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c17518079.efilter)
	tc:RegisterEffect(e2)
	--reflect battle dam
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e3:SetValue(1)
	tc:RegisterEffect(e3)
	end
	end
function c17518079.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	local p=e:GetLabel()
	if tc:GetControler()~=p and not Duel.GetControl(tc,p,PHASE_BATTLE,1) and not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c17518079.efilter(e,te)
	local c=te:GetHandler()
	return   c:IsCode(72302403) or c:IsSetCard(0x23) or c:IsCode(93087299) or  c:IsCode(100000240) or c:IsCode(23615409) or c:IsCode(100000240) or c:IsCode(85101228) or c:IsCode(82498947)
	or  c:IsCode(31930787) or c:IsCode(38568567) or  c:IsCode(68140974) 
end