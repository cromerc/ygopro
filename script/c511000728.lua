--Level Award
function c511000728.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)	
	e1:SetTarget(c511000728.target)
	e1:SetOperation(c511000728.activate)
	c:RegisterEffect(e1)
end
function c511000728.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511000728.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000728.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511000728.activate(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511000728.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local t={}
		local i=1
		local p=1
		local lv=tc:GetLevel()
		for i=1,8 do 
			if lv~=i then t[p]=i p=p+1 end
		end
		t[p]=nil
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000728,0))
		local ac=Duel.AnnounceNumber(tp,table.unpack(t))
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(ac)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
