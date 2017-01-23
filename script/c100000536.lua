--ブラック・イリュージョン
function c100000536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c100000536.condition)
	e1:SetTarget(c100000536.target)
	e1:SetOperation(c100000536.activate)
	c:RegisterEffect(e1)
end
c100000536.dark_magician_list=true
function c100000536.cfilter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsFaceup() and c:IsCode(46986414) and c:IsControler(tp)
end
function c100000536.condition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetChainInfo(ev-1,CHAININFO_TRIGGERING_EFFECT):IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	if not re:IsActiveType(TYPE_MONSTER) or ep==tp then return false end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_BECOME_TARGET,true)
	if res then
		if trp~=tp and tre:IsActiveType(TYPE_MONSTER) and teg:FilterCount(c100000536.cfilter,nil,tp)==1 then
			local g=teg:Filter(c100000536.cfilter,nil,tp)
			e:SetLabelObject(g:GetFirst())
			return true
		end
	end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_RELEASE)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tc+tg:FilterCount(c100000536.cfilter,nil,tp)-tg:GetCount()==1 then
		local g=tg:Filter(c100000536.cfilter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return true
	end
	return false
end
function c100000536.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c100000536.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(c100000536.efilter)
		tc:RegisterEffect(e2)
	end
	Duel.Draw(1-tp,1,REASON_EFFECT)
end
function c100000536.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER)
end
