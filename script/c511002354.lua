--Hero Pressure
function c511002354.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002354.target)
	e1:SetOperation(c511002354.activate)
	c:RegisterEffect(e1)
end
function c511002354.cfilter(c)
	return c:IsSetCard(0x3008) and c:IsFaceup()
end
function c511002354.filter(c)
	return c:IsFaceup() and (c:GetAttack()>0 or c:GetDefense()>0)
end
function c511002354.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002354.cfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c511002354.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c511002354.activate(e,tp,eg,ep,ev,re,r,rp)
	local val=Duel.GetMatchingGroupCount(c511002354.cfilter,tp,LOCATION_MZONE,0,nil)*300
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511002354.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local efchk=0
		if tc:GetAttack()>0 then
			efchk=efchk+1
		end
		if tc:GetDefense()>0 then
			efchk=efchk+2
		end
		local op=0
		if efchk==3 then
			op=Duel.SelectOption(tp,aux.Stringid(92142169,0),aux.Stringid(511002354,0))
		elseif efchk==1 then
			op=0
		else
			op=1
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		if op==0 then
			e1:SetCode(EFFECT_UPDATE_ATTACK)
		else
			e1:SetCode(EFFECT_UPDATE_DEFENSE)
		end
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-val)
		tc:RegisterEffect(e1)
	end
end
