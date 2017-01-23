--Final Countup
--Scripted by Snrk
function c511008020.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511008020.condition)
	e1:SetTarget(c511008020.target)
	e1:SetOperation(c511008020.activate)
	c:RegisterEffect(e1)
	if not c511008020.global_check then
		c511008020.global_check=true
		c511008020[0]=0
		c511008020[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PAY_LPCOST)
		ge1:SetOperation(c511008020.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_DAMAGE)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511008020.checkop(e,tp,eg,ep,ev,re,r,rp)
	--Debug.Message("atk 1 "..ev.."")
	c511008020[ep]=c511008020[ep]+ev
end
function c511008020.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x7f)
end
function c511008020.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)
end
function c511008020.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingTarget(c511008020.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511008020.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetParam(c511008020[tp])
	--Debug.Message("atk 2 "..c511008020[tp].."")
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,nil,0,tp,c511008020[tp])
end
function c511008020.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end
