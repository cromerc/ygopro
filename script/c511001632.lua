--オーバーレイ・リジェネレート
function c511001632.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001632.target)
	e1:SetOperation(c511001632.activate)
	c:RegisterEffect(e1)
end
function c511001632.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001632.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct1=Duel.GetMatchingGroupCount(c511001632.filter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(c511001632.filter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return ct1+ct2>0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=ct1 
		and Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=ct2 end
end
function c511001632.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511001632.filter,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(c511001632.filter,tp,0,LOCATION_MZONE,nil)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<g1:GetCount() 
		or Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)<g2:GetCount() then return end
	if g1:GetCount()>0 then
		local o=Duel.GetDecktopGroup(tp,g1:GetCount())
		Duel.DisableShuffleCheck()
		while o:GetCount()>0 and g1:GetCount()>0 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local sgo=o:Select(tp,1,1,nil)
			o:Sub(sgo)
			local sg=g1:Select(tp,1,1,nil)
			g1:Sub(sg)
			Duel.Overlay(sg:GetFirst(),sgo)
		end
	end
	if g2:GetCount()>0 then
		local o=Duel.GetDecktopGroup(1-tp,g2:GetCount())
		Duel.DisableShuffleCheck()
		while o:GetCount()>0 and g2:GetCount()>0 do
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local sgo=o:Select(1-tp,1,1,nil)
			o:Sub(sgo)
			local sg=g2:Select(1-tp,1,1,nil)
			g2:Sub(sg)
			Duel.Overlay(sg:GetFirst(),sgo)
		end
	end
end
