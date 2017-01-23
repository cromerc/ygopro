--機皇帝スキエル∞
function c100000056.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)	
	e1:SetValue(c100000056.operation)
	c:RegisterEffect(e1)
	--defup
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c100000056.efr)
	c:RegisterEffect(e3)
	--equip
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100000056,1))
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(c100000056.efr)
	e4:SetTarget(c100000056.eqtg)
	e4:SetOperation(c100000056.eqop)
	c:RegisterEffect(e4)
	--only 1 can exists
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SUMMON)
	e5:SetCondition(c100000056.excon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(EFFECT_SPSUMMON_CONDITION)
	e7:SetValue(c100000056.splimit)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SELF_DESTROY)
	e8:SetCondition(c100000056.descon)
	c:RegisterEffect(e8)	
end
c100000056.collection={
	[39648965]=true;[68140974]=true; --Wisel
	[75733063]=true;[31930787]=true; --Skiel
	[2137678]=true;[4545683]=true; --Granel
}
function c100000056.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x300) or c100000056.collection[c:GetCode()])
end
function c100000056.operation(e,c)
	local sup=0
	local sg=Duel.GetMatchingGroup(c100000056.filter,c:GetControler(),LOCATION_MZONE,0,c)
	local sbc=sg:GetFirst()
	while sbc do
		sup=sup+sbc:GetAttack()
		sbc=sg:GetNext()
	end
	return sup
end
function c100000056.efr(e,re)
	return re:GetHandler():GetControler()~=e:GetHandler():GetControler()
end
function c100000056.eqfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToChangeControler()
end
function c100000056.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c100000056.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c100000056.eqfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c100000056.eqfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c100000056.eqlimit(e,c)
	return e:GetOwner()==c
end
function c100000056.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local atk=tc:GetTextAttack()
			if atk<0 then atk=0 end
			if not Duel.Equip(tp,tc,c,false) then return end
			--Add Equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c100000056.eqlimit)
			tc:RegisterEffect(e1)
			if atk>0 then
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_EQUIP)
				e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
				e2:SetCode(EFFECT_UPDATE_ATTACK)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				e2:SetValue(atk)
				tc:RegisterEffect(e2)
			end
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c100000056.exfilter(c,fid)
	return c:IsFaceup() and c:IsSetCard(0x3013) and (fid==nil or c:GetFieldID()<fid)
end
function c100000056.excon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000056.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c100000056.splimit(e,se,sp,st,spos,tgp)
	if bit.band(spos,POS_FACEDOWN)~=0 then return true end
	return not Duel.IsExistingMatchingCard(c100000056.exfilter,tgp,LOCATION_ONFIELD,0,1,nil)
end
function c100000056.descon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c100000056.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil,c:GetFieldID())
end