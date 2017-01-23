--Raidraptor - Rig
function c511001876.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001876.target)
	e1:SetOperation(c511001876.activate)
	c:RegisterEffect(e1)
end
function c511001876.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and not c:IsRace(RACE_WINDBEAST)
end
function c511001876.filter2(c,lv)
	return c:IsFaceup() and c:GetLevel()==lv and not c:IsRace(RACE_WINDBEAST)
end
function c511001876.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001876.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511001876.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tg=g:GetMinGroup(Card.GetLevel)
	local lv=tg:GetFirst():GetLevel()
	local t={}
	local p=1
	while g:GetCount()>0 do 
		t[p]=lv
		p=p+1
		g:Sub(tg)
		if g:GetCount()>0 then
			tg=g:GetMinGroup(Card.GetLevel)
			lv=tg:GetFirst():GetLevel()
		end
	end
	t[p]=nil
	Duel.Hint(HINT_SELECTMSG,tp,567)
	e:SetLabel(Duel.AnnounceNumber(tp,table.unpack(t)))
end
function c511001876.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001876.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_RACE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(RACE_WINDBEAST)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
