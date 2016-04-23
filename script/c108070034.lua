--墓守の審神者
function c108070034.initial_effect(c)
	--summon with 3 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(108070034,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c108070034.ttcon)
	e1:SetOperation(c108070034.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	--summon with 1 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(108070034,1))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c108070034.otcon)
	e2:SetOperation(c108070034.otop)
	e2:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e2)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetCondition(c108070034.condition)
	e4:SetTarget(c108070034.target)
	e4:SetOperation(c108070034.operation)
	c:RegisterEffect(e4)
	--tribute check
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_MATERIAL_CHECK)
	e5:SetValue(c108070034.valcheck)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
end
function c108070034.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=3
end
function c108070034.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end
function c108070034.otcon(e,c)
	if c==nil then return true end
	local g=Duel.GetTributeGroup(c)
	return c:GetLevel()>6 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and g:IsExists(Card.IsSetCard,1,nil,0x2e)
end
function c108070034.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetTributeGroup(c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:FilterSelect(tp,Card.IsSetCard,1,1,nil,0x2e)
	c:SetMaterial(sg)
	Duel.Release(sg, REASON_SUMMON+REASON_MATERIAL)
end
function c108070034.valcheck(e,c)
	local g=c:GetMaterial()
	if g:FilterCount(Card.IsSetCard,nil,0x2e)>0 then
		e:GetLabelObject():SetLabel(g:GetCount())
	else
		e:GetLabelObject():SetLabel(g:GetCount())
	end
end
function c108070034.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE and e:GetLabel()>0
end
function c108070034.filter(c)
	return c:GetLevel()>0
end
function c108070034.filter2(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c108070034.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
	 return e:GetHandler():GetMaterial():FilterCount(c108070034.filter,nil)>0
		or Duel.IsExistingMatchingCard(c108070034.filter2,tp,0,LOCATION_MZONE,1,nil)
		or Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	local sel=0
	local ac=0
	local gc=e:GetHandler():GetMaterial():FilterCount(Card.IsSetCard,nil,0x2e)
	if gc>0 then sel=sel+1 end
	if Duel.IsExistingMatchingCard(c108070034.filter2,tp,0,LOCATION_MZONE,1,nil) then sel=sel+2 end
	if Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) then sel=sel+4 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(108070034,10))
	if sel==1 then
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,2))
	elseif sel==2 then
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,3))+1
	elseif sel==4 then
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,4))+2
	elseif sel==3 then
		if gc==1 then ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,3))
		else
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,3),aux.Stringid(108070034,5)) end
		if ac==2 then ac=3 end
	elseif sel==5 then
		if gc==1 then ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,4)) 
		else
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,4),aux.Stringid(108070034,5)) end
		if ac==1 then ac=2 end
		if ac==2 then ac=4 end
	elseif sel==6 then
		if gc==1 then ac=Duel.SelectOption(tp,aux.Stringid(108070034,3),aux.Stringid(108070034,4))+1 
		else
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,3),aux.Stringid(108070034,4),aux.Stringid(108070034,5))+1 end
		if ac==3 then ac=5 end
	elseif sel==7 then
		if gc==1 then ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,3),aux.Stringid(108070034,4))
		elseif gc==2 then 
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,3),aux.Stringid(108070034,4),aux.Stringid(108070034,6),aux.Stringid(108070034,7),aux.Stringid(108070034,8))
		else
		ac=Duel.SelectOption(tp,aux.Stringid(108070034,2),aux.Stringid(108070034,3),aux.Stringid(108070034,4),aux.Stringid(108070034,6),aux.Stringid(108070034,7),aux.Stringid(108070034,8),aux.Stringid(108070034,9))
		end
	end
	e:SetLabel(ac)
end
function c108070034.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ac=e:GetLabel()
	if ac==0 or ac==3 or ac==4 or ac==6 then
		local g=c:GetMaterial()
		local tc=g:GetFirst()
		local sum=0
		while tc do
			local lv=tc:GetLevel()
			sum=sum+lv
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(sum*100)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
	if ac==1 or ac==3 or ac==5 or ac==6 then
		local sg=Duel.GetMatchingGroup(c108070034.filter2,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
	if ac==2 or ac==4 or ac==5 or ac==6 then
		local dg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local sc=dg:GetFirst()
		while sc do
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(-2000)
			sc:RegisterEffect(e2)
			local e3=e2:Clone()
			e3:SetCode(EFFECT_UPDATE_DEFENCE)
			sc:RegisterEffect(e3)
			sc=dg:GetNext()
		end
	end
end
