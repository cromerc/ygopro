--Over the Red
function c511009044.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(95100790)
	-- e1:SetCondition(c511009044.condition)
	e1:SetTarget(c511009044.target)
	e1:SetOperation(c511009044.activate)
	c:RegisterEffect(e1)
	if not c511009044.global_check then
		c511009044.global_check=true
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetOperation(c511009044.operation)
		Duel.RegisterEffect(e2,0)
	end
end

--red collection
c511009044.collection={
	[58831685]=true;[10202894]=true;[65570596]=true;[511001464]=true;[511001094]=true;
	[68722455]=true;[58165765]=true;[45462639]=true;[511001095]=true;[511000365]=true;
	[14886469]=true;[30494314]=true;[81354330]=true;[86445415]=true;[100000562]=true;
	[34475451]=true;[40975574]=true;[37132349]=true;[61019812]=true;[19025379]=true;
	[76547525]=true;[55888045]=true;[97489701]=true;[67030233]=true;[65338781]=true;
	[45313993]=true;[8706701]=true;[21142671]=true;
}

function c511009044.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(1-tp) and ev>0
end
function c511009044.filter(c,e,tp)
	return c:IsFaceup() and (c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c:IsSetCard(0x89b) or c511009044.collection[c:GetCode()]) 
		and c:IsType(TYPE_SYNCHRO) and c:IsCanBeEffectTarget(e)
end
function c511009044.rmfilter(c)
	return (c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c:IsSetCard(0x89b) or c511009044.collection[c:GetCode()]) 
		and c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost()
end
function c511009044.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) end
	if chk==0 then return eg:IsExists(c511009044.filter,1,nil,e) end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=eg:FilterSelect(tp,c511009044.filter,1,1,nil,e)
		Duel.SetTargetCard(g)
	end
end
function c511009044.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e1)
		local sg=Duel.GetMatchingGroup(c511009044.rmfilter,tp,LOCATION_GRAVE,0,nil)
		if sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(95100790,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
			local tg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(tg)
			Duel.Remove(tg,POS_FACEUP,REASON_COST)
			-- Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
			local atk=tg:GetFirst():GetAttack()
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetValue(atk)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end

--atk change check
function c511009044.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(95100790)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511009044.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(95100790,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c511009044.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	val=e:GetLabel()-c:GetAttack()
	if val>0 then
		Duel.RaiseEvent(c,95100790,re,REASON_EFFECT,rp,tp,val)
	end
	e:SetLabel(c:GetAttack())
end